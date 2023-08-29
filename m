Return-Path: <bpf+bounces-8917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F478C4DD
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 15:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF241C20A2D
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 13:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081E615AC2;
	Tue, 29 Aug 2023 13:07:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781714AB3;
	Tue, 29 Aug 2023 13:07:14 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BCF1B3;
	Tue, 29 Aug 2023 06:07:12 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.186.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 880AD66071E6;
	Tue, 29 Aug 2023 14:07:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1693314431;
	bh=8Wtv+QhvUdjdJ/jko6FnYAEzfHl3uvKugwa3XSczp28=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=coh/Jt0W5VONNL5NSB23AsiFbKjjE7QK6ZgSqA83uPXBNAqwD9QmULSJEBOC1QueW
	 VtX6xbsglu6XukHGfZ9LV9Fgi7nAlRecbMTzIomh7X6YYx2XmLaQ9yWvMsgzlihB+y
	 tMR0hdjVfQt9eidTo/LnT3yHO+i/4/NQrxPctDdVh9PAyEgLWcw97Vk3Ev1cU00cVi
	 GWZNp6lwx1tVy5iZU+WaEiNjZwie8ciGtCwdyAlGM08yVrz/P4a+pG3PEUZM/mNH9v
	 RiKJGI67Xj8Lt/T5Djh1u/V5Dzpz4z7lCb+CX3G7C6jfBNbgVdsmONplcCxMclZn3O
	 PCVy1wnnYW9KA==
Message-ID: <c3a5d08e-9c7c-4888-916a-ba4bd22a3319@collabora.com>
Date: Tue, 29 Aug 2023 18:07:04 +0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Linux Networking <netdev@vger.kernel.org>, Linux BPF <bpf@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>
Subject: Re: Fwd: inet6_sock_destruct->inet_sock_destruct trigger Call Trace
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <8bfaee54-3117-65d3-d723-6408edf93961@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <8bfaee54-3117-65d3-d723-6408edf93961@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/16/23 5:43 PM, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
>> When the IPv6 address or NIC configuration changes, the following kern=
el warnings may be triggered:
>>
>> Thu Jun 15 09:02:31 2023 daemon.info : 09[KNL] interface utun deleted
>> Thu Jun 15 09:02:31 2023 daemon.info : 13[KNL] interface utun deleted
>> Thu Jun 15 09:02:32 2023 daemon.notice procd: /etc/rc.d/S99zerotier: d=
isabled in config
>> Thu Jun 15 09:02:33 2023 daemon.info procd: - init complete -
>> Thu Jun 15 09:02:45 2023 daemon.info : 09[KNL] interface utun deleted
>> Thu Jun 15 09:02:45 2023 daemon.info : 15[KNL] interface utun deleted
>> Thu Jun 15 09:02:48 2023 user.notice firewall: Reloading firewall due =
to ifup of lan6 (br-switch)
>> Thu Jun 15 09:02:51 2023 daemon.err uhttpd[2929]: cat: can't open '/tm=
p/cpu.usage': No such file or directory
>> Thu Jun 15 09:03:03 2023 user.notice firewall: Reloading firewall due =
to ifup of wg (wg)
>> Thu Jun 15 09:03:03 2023 daemon.info : 13[KNL] interface tunh activate=
d
>> Thu Jun 15 09:03:03 2023 daemon.info : 16[KNL] fe80::5efe:c0a8:7df9 ap=
peared on tunh
>> Thu Jun 15 09:03:03 2023 daemon.info : 08[KNL] 10.10.13.1 appeared on =
tunh
>> Thu Jun 15 09:03:03 2023 daemon.info : 13[KNL] interface utun deleted
>> Thu Jun 15 09:03:03 2023 daemon.info : 05[KNL] interface utun deleted
>> Thu Jun 15 09:03:04 2023 auth.err passwd: password for root changed by=
 root
>> Thu Jun 15 09:03:17 2023 daemon.err uhttpd[2929]: sh: /etc/init.d/task=
s: line 7: extra_command: not found
>> Thu Jun 15 09:03:17 2023 daemon.err uhttpd[2929]: sh: /etc/init.d/task=
s: line 8: extra_command: not found
>> Thu Jun 15 09:03:17 2023 daemon.err uhttpd[2929]: sh: /etc/init.d/task=
s: line 9: extra_command: not found
>> Thu Jun 15 09:03:17 2023 daemon.err uhttpd[2929]: sh: /etc/init.d/task=
s: line 10: extra_command: not found
>> Thu Jun 15 09:03:17 2023 daemon.err uhttpd[2929]: sh: /etc/init.d/task=
s: line 11: extra_command: not found
>> Thu Jun 15 09:03:23 2023 daemon.err uhttpd[2929]: sh: /etc/init.d/task=
s: line 7: extra_command: not found
>> Thu Jun 15 09:03:23 2023 daemon.err uhttpd[2929]: sh: /etc/init.d/task=
s: line 8: extra_command: not found
>> Thu Jun 15 09:03:23 2023 daemon.err uhttpd[2929]: sh: /etc/init.d/task=
s: line 9: extra_command: not found
>> Thu Jun 15 09:03:23 2023 daemon.err uhttpd[2929]: sh: /etc/init.d/task=
s: line 10: extra_command: not found
>> Thu Jun 15 09:03:23 2023 daemon.err uhttpd[2929]: sh: /etc/init.d/task=
s: line 11: extra_command: not found
>> Thu Jun 15 09:03:35 2023 daemon.err uhttpd[2929]: Error: The backup GP=
T table is corrupt, but the primary appears OK, so that will be used.
>> Thu Jun 15 09:03:35 2023 daemon.err uhttpd[2929]: Warning: Not all of =
the space available to /dev/sda appears to be used, you can fix the GPT t=
o use all of the space (an extra 6111 blocks) or continue with the curren=
t setting?
>> Thu Jun 15 09:03:59 2023 daemon.info acpid: starting up with netlink a=
nd the input layer
>> Thu Jun 15 09:03:59 2023 daemon.info acpid: 1 rule loaded
>> Thu Jun 15 09:03:59 2023 daemon.info acpid: waiting for events: event =
logging is off
>> Thu Jun 15 09:11:16 2023 daemon.err uhttpd[2929]: getopt: unrecognized=
 option: no-validate
>> Thu Jun 15 10:06:07 2023 daemon.err uhttpd[2929]: getopt: unrecognized=
 option: no-validate
>> Thu Jun 15 10:09:27 2023 daemon.info : 09[KNL] interface utun deleted
>> Thu Jun 15 10:09:27 2023 daemon.info : 13[KNL] interface utun deleted
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.437330] ------------=
[ cut here ]------------
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.439948] WARNING: CPU=
: 1 PID: 19 at inet_sock_destruct+0x190/0x1c0
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.440967] Modules link=
ed in: pppoe ppp_async l2tp_ppp i915 wireguard video sch_fq_pie pppox ppp=
_mppe ppp_generic mt7921u mt7921s mt7921e mt7921_common mt7915e mt76x2u m=
t76x2e mt76x2_common mt76x02_usb mt76x02_lib mt76_usb mt76_sdio mt76_conn=
ac_lib mt76 mac80211 libchacha20poly1305 ipt_REJECT curve25519_x86_64 cha=
cha_x86_64 cfg80211 ax88179_178a zstd xt_time xt_tcpudp xt_tcpmss xt_stri=
ng xt_statistic xt_state xt_socket xt_recent xt_quota xt_policy xt_pkttyp=
e xt_owner xt_nat xt_multiport xt_mark xt_mac xt_limit xt_length xt_ipran=
ge xt_hl xt_helper xt_hashlimit xt_esp xt_ecn xt_dscp xt_conntrack xt_con=
nmark xt_connlimit xt_connbytes xt_comment xt_cgroup xt_bpf xt_addrtype x=
t_TPROXY xt_TCPMSS xt_REDIRECT xt_MASQUERADE xt_LOG xt_IPMARK xt_HL xt_FL=
OWOFFLOAD xt_DSCP xt_CT xt_CLASSIFY wmi via_velocity usbnet ums_usbat ums=
_sddr55 ums_sddr09 ums_karma ums_jumpshot ums_isd200 ums_freecom ums_data=
fab ums_cypress ums_alauda tulip ts_fsm ts_bm tcp_bbr slhc sch_pie sch_ca=
ke rtl8150 r8168 r8152 r8125
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.441064]  poly1305_x8=
6_64 pcnet32 nf_tproxy_ipv6 nf_tproxy_ipv4 nf_socket_ipv6 nf_socket_ipv4 =
nf_reject_ipv4 nf_nat_tftp nf_nat_snmp_basic nf_nat_sip nf_nat_pptp nf_na=
t_irc nf_nat_h323 nf_nat_ftp nf_nat_amanda nf_log_syslog nf_flow_table nf=
_conntrack_tftp nf_conntrack_snmp nf_conntrack_sip nf_conntrack_pptp nf_c=
onntrack_netlink nf_conntrack_irc nf_conntrack_h323 nf_conntrack_ftp nf_c=
onntrack_broadcast ts_kmp nf_conntrack_amanda nf_conncount mlx5_core mlx4=
_en mlx4_core mdev macvlan lzo_rle lzo libcurve25519_generic libchacha kv=
m_intel kvm ipvlan iptable_raw iptable_nat iptable_mangle iptable_filter =
ipt_ah ipt_ECN ip_tables iommu_v2 igc iavf i40e forcedeth e1000e drm_disp=
lay_helper drm_buddy crc_ccitt compat_xtables compat cls_flower br_netfil=
ter bnx2x bnx2 alx act_vlan 8139too 8139cp ntfs3 cls_bpf act_bpf sch_tbf =
sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_route cls_matchall cls_fw=
 cls_flow cls_basic act_skbedit act_mirred act_gact configs sg evdev i2c_=
dev cryptodev xt_set
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.453861]  ip_set_list=
_set ip_set_hash_netportnet ip_set_hash_netport ip_set_hash_netnet ip_set=
_hash_netiface ip_set_hash_net ip_set_hash_mac ip_set_hash_ipportnet ip_s=
et_hash_ipportip ip_set_hash_ipport ip_set_hash_ipmark ip_set_hash_ipmac =
ip_set_hash_ip ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_bitmap_ip ip=
_set st ip6table_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip=
6t_NPT ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf=
_reject_ipv6 nfsv4 nfsd nfs bonding ip_gre gre ixgbe igbvf e1000 amd_xgbe=
 mdio_devres dummy sit mdio l2tp_netlink l2tp_core udp_tunnel ip6_udp_tun=
nel ipcomp6 xfrm6_tunnel esp6 ah6 xfrm4_tunnel ipcomp esp4 ah4 ipip tunne=
l6 tunnel4 ip_tunnel udp_diag tcp_diag raw_diag inet_diag rpcsec_gss_krb5=
 auth_rpcgss veth tun nbd xfrm_user xfrm_ipcomp af_key xfrm_algo virtiofs=
 fuse lockd sunrpc grace hfs cifs oid_registry cifs_md4 cifs_arc4 asn1_de=
coder dns_resolver md_mod nls_utf8 nls_cp950 nls_cp936 ena shortcut_fe_ip=
v6 shortcut_fe crypto_user
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.462923]  algif_skcip=
her algif_rng algif_hash algif_aead af_alg sha512_ssse3 sha512_generic sh=
a1_ssse3 sha1_generic seqiv jitterentropy_rng drbg md5 hmac echainiv des_=
generic libdes deflate cts cmac authencesn authenc arc4 crypto_acompress =
nls_iso8859_1 nls_cp437 uas sdhci_pltfm xhci_plat_hcd fsl_mph_dr_of ehci_=
platform ehci_fsl igb vfat fat exfat btrfs zstd_decompress zstd_compress =
zstd_common xxhash xor raid6_pq lzo_decompress lzo_compress dm_mirror dm_=
region_hash dm_log dm_crypt dm_mod dax button_hotplug mii libphy tpm cbc =
sha256_ssse3 sha256_generic libsha256 encrypted_keys trusted
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.472554] CPU: 1 PID: =
19 Comm: ksoftirqd/1 Not tainted 6.1.34 #0
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.473025] Hardware nam=
e: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-p=
rebuilt.qemu.org 04/01/2014
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.473731] RIP: 0010:in=
et_sock_destruct+0x190/0x1c0
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.474204] Code: bc 24 =
40 01 00 00 e8 af 0d f0 ff 49 8b bc 24 88 00 00 00 e8 a2 0d f0 ff 5b 41 5=
c 5d c3 4c 89 e7 e8 e5 7e ed ff e9 70 ff ff ff <0f> 0b eb c3 0f 0b 41 8b =
84 24 54 01 00 00 85 c0 74 9d 0f 0b 41 8b
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.475522] RSP: 0018:ff=
ffc900000afda8 EFLAGS: 00010206
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.475947] RAX: 0000000=
000000e00 RBX: ffff888015c9b040 RCX: 0000000000000007
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.476450] RDX: 0000000=
000000000 RSI: 0000000000000e00 RDI: ffff888015c9b040
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.476966] RBP: ffffc90=
0000afdb8 R08: ffff88800aba5900 R09: 000000008020001a
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.477588] R10: 0000000=
040000000 R11: 0000000000000000 R12: ffff888015c9af80
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.478326] R13: ffff888=
002931540 R14: ffffc900000afe28 R15: ffff88807dd253f8
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.478872] FS:  0000000=
000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.479434] CS:  0010 DS=
: 0000 ES: 0000 CR0: 0000000080050033
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.479886] CR2: 00007f1=
1fc4cd0a0 CR3: 0000000021cbe004 CR4: 0000000000370ee0
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.480533] Call Trace:
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.480851]  <TASK>
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.481169]  ? show_regs=
=2Epart.0+0x1e/0x20
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.481631]  ? show_regs=
=2Ecold+0x8/0xd
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.482248]  ? __warn+0x=
6e/0xc0
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.483300]  ? inet_sock=
_destruct+0x190/0x1c0
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.484240]  ? report_bu=
g+0xed/0x140
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.484937]  ? handle_bu=
g+0x46/0x80
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.485448]  ? exc_inval=
id_op+0x19/0x70
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.485963]  ? asm_exc_i=
nvalid_op+0x1b/0x20
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.486360]  ? inet_sock=
_destruct+0x190/0x1c0
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.486888]  inet6_sock_=
destruct+0x16/0x20
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.487289]  __sk_destru=
ct+0x23/0x180
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.487638]  rcu_core+0x=
28f/0x690
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.487964]  rcu_core_si=
+0x9/0x10
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.488285]  __do_softir=
q+0xbd/0x1e8
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.488973]  run_ksoftir=
qd+0x24/0x40
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.489370]  smpboot_thr=
ead_fn+0xdb/0x1d0
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.489826]  kthread+0xd=
e/0x110
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.490572]  ? sort_rang=
e+0x20/0x20
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.491356]  ? kthread_c=
omplete_and_exit+0x20/0x20
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.491839]  ret_from_fo=
rk+0x1f/0x30
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.492195]  </TASK>
>> Thu Jun 15 10:09:28 2023 kern.warn kernel: [ 4071.492448] ---[ end tra=
ce 0000000000000000 ]---
>=20
> Later, the reporter revealed his setup:
>=20
>> This is an openwrt gateway device on x86_64 platform. I'm not sure the=
 exact version number that came up, it seems like 6.1.27 was not encounte=
red before. I have encountered it since kernel 6.1.32, but it is also fro=
m this version that I have relatively large IPv6 udp traffic, conntrack -=
L|grep -c udp shows that the number is between 600 - 2000.
>=20
> See Bugzilla for the full thread and attached log.
>=20
> Anyway, I'm adding it to regzbot:
>=20
> #regzbot introduced: v6.1.27..v6.1.32 https://bugzilla.kernel.org/show_=
bug.cgi?id=3D217555
> #regzbot title: kernel warning (oops) at inet_sock_destruct
The same warning has been seen on 4.14, 5.15, 6.1 and latest mainline. Th=
is
WARN_ON is present from 2008.

#regzbot monitor:
https://lore.kernel.org/all/6144228a-799f-4de3-8483-b7add903df0c@collabor=
a.com

>=20
> Thanks.
>=20
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217555

--=20
BR,
Muhammad Usama Anjum

