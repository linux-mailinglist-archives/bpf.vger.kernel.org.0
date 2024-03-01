Return-Path: <bpf+bounces-23117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1A286DBDE
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 08:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0D2EB22150
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 07:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7C69942;
	Fri,  1 Mar 2024 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vx+h9Zso"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64F51C2A
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276978; cv=none; b=nHlXmntoo1L2rMTZeQx8Zoo9oPgCru/HPXGqYipaVgYYnUHJPRWsC3Uoathlzyx5W99/LMqOXeRdT1L8jkGmjHbugA7YvauyLe1q5vqFcXqL1vuGxk3rh3W1RQAv3/D2/Srvr9CnREi+40G0jLe77lIqLl79Zjt1VczOnVwv6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276978; c=relaxed/simple;
	bh=kgk2nvusG+z+3AvVHeRTkQo6J8AXdDSEWPdDUgX44Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1yR+p4cToJ30i0B4c1f/lGNp/mbM1722feRcoa3tsyMwskodbj77ERnx4bN5hA8vTzgszlWIHQWTp1o60UUn6p7GrXE9OaZx5XYZIc5jnWeUFJVBzfHgcxTrEiulk2MkPQyt/jus9n/omQhqnAUDjC4oWbsUtfZRRulMjvhnWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Vx+h9Zso; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so15515575ad.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 23:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709276976; x=1709881776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JOssgKB7XaCifvuhcs7Kh7kifGJ3OYhTaXeLDavmy28=;
        b=Vx+h9ZsoPuEpEmGoSQU8ElyYS+Dk5qQH6BToVTVXT88euHmEBLKdbzXi5LffI01qEE
         VrO6eV49aYbmlJoyzxSN9BITf1EQXQ8UDHRpvbGEqD4/f28Hv9o89rN6a+C/8dBEbUrx
         s4GEAoag4P50ziwOolPU0uR8V2UO+qTmTf5K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709276976; x=1709881776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOssgKB7XaCifvuhcs7Kh7kifGJ3OYhTaXeLDavmy28=;
        b=s69Wct26dq8KsOGr4xytiEze9jHLWsPEvS0Ld85mJqZaa3qZFcsw4wZNaeN7ZpzpT1
         tgMzYFhB15zhp9dIxYxesg/cu6i6V9xls9UCf1FuAXOQzzxkTdWDw7hNHvR8DfLWUazm
         mWnczwRbGwEA2xcOyCVnJ12EXJExohWk+Ego9LdDawlEAKuUhYpc/A6LPlvJrt3vQwLt
         oOqryZ5N4nYmX5dKmRunTUyy5zqnh9Fj83swPiIBqDJBm6BwdKmRR5TYJgyMhKSLeZp4
         UTOQC9Ox/4QX20q/7x6JE2nG2sGpRJdZ5ubQxzRVSPkL4oQetmpT1VQIdxWCvlaX84qK
         eP1g==
X-Forwarded-Encrypted: i=1; AJvYcCUYPWELrVYDokgd3Rxb4D11wm2bP5oGXQHueaReaVid7ABWYFBaYL+55Grh3geeGDYftiB/WougBFC6+M4VHFScC1LQ
X-Gm-Message-State: AOJu0YxTuKP8ZCmK6WUs8R3gCw+pVg9Jc3a+bruUAGAdBJgTM2y36q4h
	eqgCWcfPPBjPTxqjrRlZ7vHXzl6xvcH+T6vjSOUe70Y/UzGqdtqYiPMxyVWzEQ==
X-Google-Smtp-Source: AGHT+IHTEsA3e1i6SOlIOf+6B+BFRqXmFi6kvtybw6I/ClAabVS8Q+xiDWe6nx9BZ4DGBfTrEPcM9w==
X-Received: by 2002:a17:902:ed54:b0:1dc:1379:213b with SMTP id y20-20020a170902ed5400b001dc1379213bmr742125plb.35.1709276976205;
        Thu, 29 Feb 2024 23:09:36 -0800 (PST)
Received: from fedora.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001dcc09487e8sm2673428pla.50.2024.02.29.23.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 23:09:35 -0800 (PST)
From: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mike.kravetz@oracle.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Oscar Salvador <osalvador@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH v5.15-v5.4] fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super
Date: Fri,  1 Mar 2024 01:09:10 -0600
Message-ID: <20240301070910.1287862-1-vamsi-krishna.brahmajosyula@broadcom.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Oscar Salvador <osalvador@suse.de>

commit 79d72c68c58784a3e1cd2378669d51bfd0cb7498 upstream.

When configuring a hugetlb filesystem via the fsconfig() syscall, there is
a possible NULL dereference in hugetlbfs_fill_super() caused by assigning
NULL to ctx->hstate in hugetlbfs_parse_param() when the requested pagesize
is non valid.

E.g: Taking the following steps:

     fd =3D fsopen("hugetlbfs", FSOPEN_CLOEXEC);
     fsconfig(fd, FSCONFIG_SET_STRING, "pagesize", "1024", 0);
     fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);

Given that the requested "pagesize" is invalid, ctxt->hstate will be replac=
ed
with NULL, losing its previous value, and we will print an error:

 ...
 ...
 case Opt_pagesize:
 ps =3D memparse(param->string, &rest);
 ctx->hstate =3D h;
 if (!ctx->hstate) {
         pr_err("Unsupported page size %lu MB\n", ps / SZ_1M);
         return -EINVAL;
 }
 return 0;
 ...
 ...

This is a problem because later on, we will dereference ctxt->hstate in
hugetlbfs_fill_super()

 ...
 ...
 sb->s_blocksize =3D huge_page_size(ctx->hstate);
 ...
 ...

Causing below Oops.

Fix this by replacing cxt->hstate value only when then pagesize is known
to be valid.

 kernel: hugetlbfs: Unsupported page size 0 MB
 kernel: BUG: kernel NULL pointer dereference, address: 0000000000000028
 kernel: #PF: supervisor read access in kernel mode
 kernel: #PF: error_code(0x0000) - not-present page
 kernel: PGD 800000010f66c067 P4D 800000010f66c067 PUD 1b22f8067 PMD 0
 kernel: Oops: 0000 [#1] PREEMPT SMP PTI
 kernel: CPU: 4 PID: 5659 Comm: syscall Tainted: G            E      6.8.0-=
rc2-default+ #22 5a47c3fef76212addcc6eb71344aabc35190ae8f
 kernel: Hardware name: Intel Corp. GROVEPORT/GROVEPORT, BIOS GVPRCRB1.86B.=
0016.D04.1705030402 05/03/2017
 kernel: RIP: 0010:hugetlbfs_fill_super+0xb4/0x1a0
 kernel: Code: 48 8b 3b e8 3e c6 ed ff 48 85 c0 48 89 45 20 0f 84 d6 00 00 =
00 48 b8 ff ff ff ff ff ff ff 7f 4c 89 e7 49 89 44 24 20 48 8b 03 <8b> 48 2=
8 b8 00 10 00 00 48 d3 e0 49 89 44 24 18 48 8b 03 8b 40 28
 kernel: RSP: 0018:ffffbe9960fcbd48 EFLAGS: 00010246
 kernel: RAX: 0000000000000000 RBX: ffff9af5272ae780 RCX: 0000000000372004
 kernel: RDX: ffffffffffffffff RSI: ffffffffffffffff RDI: ffff9af555e9b000
 kernel: RBP: ffff9af52ee66b00 R08: 0000000000000040 R09: 0000000000370004
 kernel: R10: ffffbe9960fcbd48 R11: 0000000000000040 R12: ffff9af555e9b000
 kernel: R13: ffffffffa66b86c0 R14: ffff9af507d2f400 R15: ffff9af507d2f400
 kernel: FS:  00007ffbc0ba4740(0000) GS:ffff9b0bd7000000(0000) knlGS:000000=
0000000000
 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: CR2: 0000000000000028 CR3: 00000001b1ee0000 CR4: 00000000001506f0
 kernel: Call Trace:
 kernel:  <TASK>
 kernel:  ? __die_body+0x1a/0x60
 kernel:  ? page_fault_oops+0x16f/0x4a0
 kernel:  ? search_bpf_extables+0x65/0x70
 kernel:  ? fixup_exception+0x22/0x310
 kernel:  ? exc_page_fault+0x69/0x150
 kernel:  ? asm_exc_page_fault+0x22/0x30
 kernel:  ? __pfx_hugetlbfs_fill_super+0x10/0x10
 kernel:  ? hugetlbfs_fill_super+0xb4/0x1a0
 kernel:  ? hugetlbfs_fill_super+0x28/0x1a0
 kernel:  ? __pfx_hugetlbfs_fill_super+0x10/0x10
 kernel:  vfs_get_super+0x40/0xa0
 kernel:  ? __pfx_bpf_lsm_capable+0x10/0x10
 kernel:  vfs_get_tree+0x25/0xd0
 kernel:  vfs_cmd_create+0x64/0xe0
 kernel:  __x64_sys_fsconfig+0x395/0x410
 kernel:  do_syscall_64+0x80/0x160
 kernel:  ? syscall_exit_to_user_mode+0x82/0x240
 kernel:  ? do_syscall_64+0x8d/0x160
 kernel:  ? syscall_exit_to_user_mode+0x82/0x240
 kernel:  ? do_syscall_64+0x8d/0x160
 kernel:  ? exc_page_fault+0x69/0x150
 kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0x76
 kernel: RIP: 0033:0x7ffbc0cb87c9
 kernel: Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 97 96 0d 00 f7 d8 64 89 01 48
 kernel: RSP: 002b:00007ffc29d2f388 EFLAGS: 00000206 ORIG_RAX: 000000000000=
01af
 kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffbc0cb87c9
 kernel: RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
 kernel: RBP: 00007ffc29d2f3b0 R08: 0000000000000000 R09: 0000000000000000
 kernel: R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
 kernel: R13: 00007ffc29d2f4c0 R14: 0000000000000000 R15: 0000000000000000
 kernel:  </TASK>
 kernel: Modules linked in: rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_=
resolver(E) nfs(E) lockd(E) grace(E) sunrpc(E) netfs(E) af_packet(E) bridge=
(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) intel_rapl_msr(E) intel=
_rapl_common(E) iTCO_wdt(E) intel_pmc_bxt(E) sb_edac(E) iTCO_vendor_support=
(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) rf=
kill(E) ipmi_ssif(E) kvm(E) acpi_ipmi(E) irqbypass(E) pcspkr(E) igb(E) ipmi=
_si(E) mei_me(E) i2c_i801(E) joydev(E) intel_pch_thermal(E) i2c_smbus(E) dc=
a(E) lpc_ich(E) mei(E) ipmi_devintf(E) ipmi_msghandler(E) acpi_pad(E) tiny_=
power_button(E) button(E) fuse(E) efi_pstore(E) configfs(E) ip_tables(E) x_=
tables(E) ext4(E) mbcache(E) jbd2(E) hid_generic(E) usbhid(E) sd_mod(E) t10=
_pi(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) polyval_clmulni(=
E) ahci(E) xhci_pci(E) polyval_generic(E) gf128mul(E) ghash_clmulni_intel(E=
) sha512_ssse3(E) sha256_ssse3(E) xhci_pci_renesas(E) libahci(E) ehci_pci(E=
) sha1_ssse3(E) xhci_hcd(E) ehci_hcd(E) libata(E)
 kernel:  mgag200(E) i2c_algo_bit(E) usbcore(E) wmi(E) sg(E) dm_multipath(E=
) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi=
_common(E) aesni_intel(E) crypto_simd(E) cryptd(E)
 kernel: Unloaded tainted modules: acpi_cpufreq(E):1 fjes(E):1
 kernel: CR2: 0000000000000028
 kernel: ---[ end trace 0000000000000000 ]---
 kernel: RIP: 0010:hugetlbfs_fill_super+0xb4/0x1a0
 kernel: Code: 48 8b 3b e8 3e c6 ed ff 48 85 c0 48 89 45 20 0f 84 d6 00 00 =
00 48 b8 ff ff ff ff ff ff ff 7f 4c 89 e7 49 89 44 24 20 48 8b 03 <8b> 48 2=
8 b8 00 10 00 00 48 d3 e0 49 89 44 24 18 48 8b 03 8b 40 28
 kernel: RSP: 0018:ffffbe9960fcbd48 EFLAGS: 00010246
 kernel: RAX: 0000000000000000 RBX: ffff9af5272ae780 RCX: 0000000000372004
 kernel: RDX: ffffffffffffffff RSI: ffffffffffffffff RDI: ffff9af555e9b000
 kernel: RBP: ffff9af52ee66b00 R08: 0000000000000040 R09: 0000000000370004
 kernel: R10: ffffbe9960fcbd48 R11: 0000000000000040 R12: ffff9af555e9b000
 kernel: R13: ffffffffa66b86c0 R14: ffff9af507d2f400 R15: ffff9af507d2f400
 kernel: FS:  00007ffbc0ba4740(0000) GS:ffff9b0bd7000000(0000) knlGS:000000=
0000000000
 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: CR2: 0000000000000028 CR3: 00000001b1ee0000 CR4: 00000000001506f0

Link: https://lkml.kernel.org/r/20240130210418.3771-1-osalvador@suse.de
Fixes: 32021982a324 ("hugetlbfs: Convert to fs_context")
Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@bro=
adcom.com>
---
 fs/hugetlbfs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 54379ee573b1..9b6004bc96de 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1234,6 +1234,7 @@ static int hugetlbfs_parse_param(struct fs_context *f=
c, struct fs_parameter *par
 {
 	struct hugetlbfs_fs_context *ctx =3D fc->fs_private;
 	struct fs_parse_result result;
+	struct hstate *h;
 	char *rest;
 	unsigned long ps;
 	int opt;
@@ -1278,11 +1279,12 @@ static int hugetlbfs_parse_param(struct fs_context =
*fc, struct fs_parameter *par
=20
 	case Opt_pagesize:
 		ps =3D memparse(param->string, &rest);
-		ctx->hstate =3D size_to_hstate(ps);
-		if (!ctx->hstate) {
+		h =3D size_to_hstate(ps);
+		if (!h) {
 			pr_err("Unsupported page size %lu MB\n", ps >> 20);
 			return -EINVAL;
 		}
+		ctx->hstate =3D h;
 		return 0;
=20
 	case Opt_min_size:
--=20
2.43.2


