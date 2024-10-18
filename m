Return-Path: <bpf+bounces-42410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01009A3D40
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 13:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668621F219DA
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2CE2022CE;
	Fri, 18 Oct 2024 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIBZIMVa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A41153800;
	Fri, 18 Oct 2024 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729250809; cv=none; b=UT9dpkTFrRNZiQAccZvY/8VdG8ZP4BMEvq5MWyDfd0zv3qbuVRo1P4dZoEBNIVK62qic+GBmt2+ER+pvESxut7/qWq9U11RX2zTmtZyaBUWMxm9bA/UfFMfJ5/MZHuNVP9nr8/lsiUH9ep9wQnG/5xZGUbTuCFjQRXac8PFX6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729250809; c=relaxed/simple;
	bh=Xgk2ys8BE3WpGe4YIyikUspGoN6vpRUvSIVSiF70RV0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LYISF0CCqYy98CkL8T9iH5a4FVSATEcLJiUds8zCJ12RWZQnslInsWp9a0zzgICzRn1IqBcIQ2S+ny+IgoG/BYINo8PrCPPDQfWbxgsnbXybvQTjWrVOizbPck1tw+7nYDG1s+KWfMlmXlOlmWj0KUHQIkqFt3kL35y9v6E2KOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIBZIMVa; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50d3d2d0775so625630e0c.3;
        Fri, 18 Oct 2024 04:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729250805; x=1729855605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xgk2ys8BE3WpGe4YIyikUspGoN6vpRUvSIVSiF70RV0=;
        b=IIBZIMVaoBfhiWStRZCizrhW8BEfjwPw6wmMTBVs5DYLHbClgbFomjLGh0+8OEV7fR
         idRX/F4etIFhiUUOnnhdPyUIl4CceLq7DrI6Yeo/S8biy+8g9XV47lTIqwOJeRRHfpTf
         4Y76sQp7FAME8YWtMl/EaX3EHk1jNi0cZH/N7VQlolLZADw23ShfabT7tCFSFfmHaDbD
         pC4mB07wjhXbLa3f2gqRQb+g/Hh/0XT2blP39rFB53MDTb1wjDLB6gBJTRwACsDQ74zI
         MkHBl+Yo0PWwqgAxHaFucneZbX+gxw11PQRxE8bipyR0zqjo/dPkJdJMFz/pTrGxfYfe
         xqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729250805; x=1729855605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xgk2ys8BE3WpGe4YIyikUspGoN6vpRUvSIVSiF70RV0=;
        b=SZDLkCHN6K3lmbnFBo4/FuLDiAVTZ0HBF+kOy2KUW9gFTkE80YbxR7s6IXlnYs5Yxe
         blCZ+Wj6Hp7EDddwqbFHAeYXrNAPwE6LXz72403IAF363IKLv+ss6+xLhu3U3IWbq2m+
         xvOhXSw9QM+XWQbblZjct/rhzRudgGsUhIQYPNl3r3+ZXT6lq5uDsyoX1H6Q42wvMa+y
         BwCD1/gD+JpHxxuXTWwsqkFSHAuTNxvGVgQfvdZW9xUWIV2xKLzUyFHtc4HShXmIzS0k
         Epg5TwrgnguPlo0N6SWmETNvdDE7cU8r1mL4QdL8rrWadEnwrmfUzN/F2GggaAm18vOx
         Q4mw==
X-Forwarded-Encrypted: i=1; AJvYcCUPj2iOxrjeBsqpyKYjpmsRgrhqICQALhEEZ3dpdXEoUgmV/vRtDjgbXch8/JDKASpKMDU=@vger.kernel.org, AJvYcCVKzCEYxRTtEWrPJHnEeRPCTvgVsd4YsBjNB/AXZD+mmOYaCeg5QM0uKlKtIKbvVrwsMIprt8IOf/yA8aci@vger.kernel.org
X-Gm-Message-State: AOJu0YzZfCbWkWJtPFqyybfWjWlAbefT6r21CMHxV192jeUoqqhFwUWl
	ZtejjFQ8INK0B4+YYrRxYYdUyV4oRm5jZ7FxHWVSGBOsrQwCzrTtF25dNyfSKIl+On5u0rKYrYx
	/8B05KZvPoR2g/w37MCj/UYnHdr4=
X-Google-Smtp-Source: AGHT+IENvH+BBNaKBwj0riDQSt4xueRShTcw0HoaxVbdJBUV86jA05Ecng/F8zTDlJRcw60eyaKIbAreVmiYR4ihyC4=
X-Received: by 2002:a05:6122:16a3:b0:50d:4285:1409 with SMTP id
 71dfb90a1353d-50dda1badddmr1937540e0c.6.1729250804819; Fri, 18 Oct 2024
 04:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Guo <guohui.study@gmail.com>
Date: Fri, 18 Oct 2024 19:26:33 +0800
Message-ID: <CAHOo4gJO+Bx9w-kxbSFt1=SPQUYrr29EPmCerypZTAfFdWocYg@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in build_id_parse_nofault
To: Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kernel Maintainers,
we found a crash "BUG: unable to handle kernel paging request in
build_id_parse_nofault" (it seems like a KASAN and makes the kernel
reboot) in upstream, we also have successfully reproduced it manually:

HEAD Commit: 9852d85ec9d492ebef56dc5f229416c925758edc(tag 'v6.12-rc1')
kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBugs=
/main/6.12.config

console output:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec=
9d492ebef56dc5f229416c925758edc/7a4626c1fd3c932f5ee145636d9b82d152708357/lo=
g0
repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
main/9852d85ec9d492ebef56dc5f229416c925758edc/7a4626c1fd3c932f5ee145636d9b8=
2d152708357/repro.report
syz reproducer:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec=
9d492ebef56dc5f229416c925758edc/7a4626c1fd3c932f5ee145636d9b82d152708357/re=
pro.prog
c reproducer: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
main/9852d85ec9d492ebef56dc5f229416c925758edc/7a4626c1fd3c932f5ee145636d9b8=
2d152708357/repro.cprog


Please let me know if there is anything I can help with.
Best,
Hui Guo

This is the crash log I got by reproducing the bug based on the above
environment=EF=BC=8C
I have piped this log through decode_stacktrace.sh to better
understand the cause of the bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2024/10/18 11:15:33 parsed 1 programs
[ 38.223243][ T8407] Adding 124996k swap on ./swap-file. Priority:0
extents:1 across:124996k
[ 39.172894][ T8455] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
[ 39.174859][ T8455] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
[ 39.176802][ T8455] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > 9
[ 39.182619][ T8455] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
[ 39.185043][ T8455] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > 3
[ 39.187014][ T8455] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
[ 39.250575][ T64] wlan0: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 39.252317][ T64] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:5=
0
[ 39.261274][ T118] wlan1: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 39.263161][ T118] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:=
50
[ 39.268872][ T8452] chnl_net:caif_netlink_parms(): no params data found
[ 39.288658][ T8452] bridge0: port 1(bridge_slave_0) entered blocking state
[ 39.290230][ T8452] bridge0: port 1(bridge_slave_0) entered disabled state
[ 39.291807][ T8452] bridge_slave_0: entered allmulticast mode
[ 39.293398][ T8452] bridge_slave_0: entered promiscuous mode
[ 39.294994][ T8452] bridge0: port 2(bridge_slave_1) entered blocking state
[ 39.296582][ T8452] bridge0: port 2(bridge_slave_1) entered disabled state
[ 39.297982][ T8452] bridge_slave_1: entered allmulticast mode
[ 39.299353][ T8452] bridge_slave_1: entered promiscuous mode
[ 39.304797][ T8452] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[ 39.306061][ T8452] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[ 39.316713][ T8452] team0: Port device team_slave_0 added
[ 39.317725][ T8452] team0: Port device team_slave_1 added
[ 39.323040][ T8452] batman_adv: batadv0: Adding interface: batadv_slave_0
[ 39.323927][ T8452] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over thi.
[ 39.327301][ T8452] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[ 39.328902][ T8452] batman_adv: batadv0: Adding interface: batadv_slave_1
[ 39.329788][ T8452] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over thi.
[ 39.333021][ T8452] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[ 39.340087][ T8452] hsr_slave_0: entered promiscuous mode
[ 39.340975][ T8452] hsr_slave_1: entered promiscuous mode
[ 39.356662][ T8452] netdevsim netdevsim8 netdevsim0: renamed from eth0
[ 39.358010][ T8452] netdevsim netdevsim8 netdevsim1: renamed from eth1
[ 39.359246][ T8452] netdevsim netdevsim8 netdevsim2: renamed from eth2
[ 39.360503][ T8452] netdevsim netdevsim8 netdevsim3: renamed from eth3
[ 39.366505][ T8452] bridge0: port 2(bridge_slave_1) entered blocking state
[ 39.367461][ T8452] bridge0: port 2(bridge_slave_1) entered forwarding sta=
te
[ 39.368426][ T8452] bridge0: port 1(bridge_slave_0) entered blocking state
[ 39.369376][ T8452] bridge0: port 1(bridge_slave_0) entered forwarding sta=
te
[ 39.376067][ T8452] 8021q: adding VLAN 0 to HW filter on device bond0
[ 39.378494][ T58] bridge0: port 1(bridge_slave_0) entered disabled state
[ 39.380388][ T58] bridge0: port 2(bridge_slave_1) entered disabled state
[ 39.383573][ T8452] 8021q: adding VLAN 0 to HW filter on device team0
[ 39.385513][ T129] bridge0: port 1(bridge_slave_0) entered blocking state
[ 39.386515][ T129] bridge0: port 1(bridge_slave_0) entered forwarding stat=
e
[ 39.388285][ T129] bridge0: port 2(bridge_slave_1) entered blocking state
[ 39.389212][ T129] bridge0: port 2(bridge_slave_1) entered forwarding stat=
e
[ 39.414402][ T8452] 8021q: adding VLAN 0 to HW filter on device batadv0
[ 39.443108][ T8452] veth0_vlan: entered promiscuous mode
[ 39.444506][ T8452] veth1_vlan: entered promiscuous mode
[ 39.447867][ T8452] veth0_macvtap: entered promiscuous mode
[ 39.448978][ T8452] veth1_macvtap: entered promiscuous mode
[ 39.451123][ T8452] batman_adv: batadv0: Interface activated: batadv_slave=
_0
[ 39.453210][ T8452] batman_adv: batadv0: Interface activated: batadv_slave=
_1
[ 39.454699][ T8452] netdevsim netdevsim8 netdevsim0: set [1, 0] type
2 family 0 port 6081 - 0
[ 39.455802][ T8452] netdevsim netdevsim8 netdevsim1: set [1, 0] type
2 family 0 port 6081 - 0
[ 39.457000][ T8452] netdevsim netdevsim8 netdevsim2: set [1, 0] type
2 family 0 port 6081 - 0
[ 39.458110][ T8452] netdevsim netdevsim8 netdevsim3: set [1, 0] type
2 family 0 port 6081 - 0
2024/10/18 11:15:38 executed programs: 0
[ 39.548206][ T4644] Bluetooth: hci1: unexpected cc 0x0c03 length: 249 > 1
[ 39.549912][ T4644] Bluetooth: hci1: unexpected cc 0x1003 length: 249 > 9
[ 39.551576][ T4644] Bluetooth: hci1: unexpected cc 0x1001 length: 249 > 9
[ 39.553419][ T4644] Bluetooth: hci1: unexpected cc 0x0c23 length: 249 > 4
[ 39.555163][ T4644] Bluetooth: hci1: unexpected cc 0x0c25 length: 249 > 3
[ 39.557166][ T4644] Bluetooth: hci1: unexpected cc 0x0c38 length: 249 > 2
[ 39.573072][ T9822] chnl_net:caif_netlink_parms(): no params data found
[ 39.591292][ T9822] bridge0: port 1(bridge_slave_0) entered blocking state
[ 39.592190][ T9822] bridge0: port 1(bridge_slave_0) entered disabled state
[ 39.593076][ T9822] bridge_slave_0: entered allmulticast mode
[ 39.593932][ T9822] bridge_slave_0: entered promiscuous mode
[ 39.594900][ T9822] bridge0: port 2(bridge_slave_1) entered blocking state
[ 39.595782][ T9822] bridge0: port 2(bridge_slave_1) entered disabled state
[ 39.596731][ T9822] bridge_slave_1: entered allmulticast mode
[ 39.597574][ T9822] bridge_slave_1: entered promiscuous mode
[ 39.604530][ T9822] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[ 39.607029][ T9822] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[ 39.615457][ T9822] team0: Port device team_slave_0 added
[ 39.617375][ T9822] team0: Port device team_slave_1 added
[ 39.625282][ T9822] batman_adv: batadv0: Adding interface: batadv_slave_0
[ 39.626981][ T9822] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over thi.
[ 39.632560][ T9822] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[ 39.635076][ T9822] batman_adv: batadv0: Adding interface: batadv_slave_1
[ 39.636636][ T9822] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over thi.
[ 39.642100][ T9822] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[ 39.650395][ T9822] hsr_slave_0: entered promiscuous mode
[ 39.651267][ T9822] hsr_slave_1: entered promiscuous mode
[ 39.652069][ T9822] debugfs: Directory 'hsr0' with parent 'hsr'
already present!
[ 39.653013][ T9822] Cannot create hsr debugfs directory
[ 39.672662][ T9822] netdevsim netdevsim0 netdevsim0: renamed from eth0
[ 39.673919][ T9822] netdevsim netdevsim0 netdevsim1: renamed from eth1
[ 39.675129][ T9822] netdevsim netdevsim0 netdevsim2: renamed from eth2
[ 39.676538][ T9822] netdevsim netdevsim0 netdevsim3: renamed from eth3
[ 39.682809][ T9822] bridge0: port 2(bridge_slave_1) entered blocking state
[ 39.683726][ T9822] bridge0: port 2(bridge_slave_1) entered forwarding sta=
te
[ 39.684657][ T9822] bridge0: port 1(bridge_slave_0) entered blocking state
[ 39.685542][ T9822] bridge0: port 1(bridge_slave_0) entered forwarding sta=
te
[ 39.691506][ T9822] 8021q: adding VLAN 0 to HW filter on device bond0
[ 39.693763][ T11] bridge0: port 1(bridge_slave_0) entered disabled state
[ 39.694932][ T11] bridge0: port 2(bridge_slave_1) entered disabled state
[ 39.697301][ T9822] 8021q: adding VLAN 0 to HW filter on device team0
[ 39.699056][ T11] bridge0: port 1(bridge_slave_0) entered blocking state
[ 39.699992][ T11] bridge0: port 1(bridge_slave_0) entered forwarding state
[ 39.701780][ T92] bridge0: port 2(bridge_slave_1) entered blocking state
[ 39.703361][ T92] bridge0: port 2(bridge_slave_1) entered forwarding state
[ 39.727403][ T9822] 8021q: adding VLAN 0 to HW filter on device batadv0
[ 39.732201][ T9822] veth0_vlan: entered promiscuous mode
[ 39.733620][ T9822] veth1_vlan: entered promiscuous mode
[ 39.736818][ T9822] veth0_macvtap: entered promiscuous mode
[ 39.737994][ T9822] veth1_macvtap: entered promiscuous mode
[ 39.740016][ T9822] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_0
[ 39.741405][ T9822] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[ 39.742949][ T9822] batman_adv: batadv0: Interface activated: batadv_slave=
_0
[ 39.744666][ T9822] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3f) already exists on: batadv_slave_1
[ 39.746141][ T9822] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[ 39.747584][ T9822] batman_adv: batadv0: Interface activated: batadv_slave=
_1
[ 39.749002][ T9822] netdevsim netdevsim0 netdevsim0: set [1, 0] type
2 family 0 port 6081 - 0
[ 39.750120][ T9822] netdevsim netdevsim0 netdevsim1: set [1, 0] type
2 family 0 port 6081 - 0
[ 39.751235][ T9822] netdevsim netdevsim0 netdevsim2: set [1, 0] type
2 family 0 port 6081 - 0
[ 39.752327][ T9822] netdevsim netdevsim0 netdevsim3: set [1, 0] type
2 family 0 port 6081 - 0
[ 39.819569][ T129] wlan0: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 39.820456][ T129] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:=
50
[ 39.824077][ T58] wlan1: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 39.825846][ T58] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:5=
0
[ 39.832652][T10850] BUG: unable to handle page fault for address:
ffff88810dfe5000
[ 39.833678][T10850] #PF: supervisor read access in kernel mode
[ 39.834408][T10850] #PF: error_code(0x0000) - not-present page
[ 39.835152][T10850] PGD 8201067 P4D 8201067 PUD 8205067 PMD 10de03063
PTE 800ffffef201a060
[ 39.836238][T10850] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 39.837088][T10850] CPU: 7 UID: 0 PID: 10850 Comm: syz.0.15 Not
tainted 6.12.0-rc1 #5
[ 39.838346][T10850] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[39.839726][T10850] RIP: 0010:memcmp
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/string.c:676)
[ 39.840434][T10850] Code: 06 48 39 07 75 17 48 83 c7 08 48 83 c6 08
48 83 ea 08 48 83 fa 07 77 e6 48 85 d2 74 20 31 c9 eb 09 48 83 c1 01
48 39 ca 74 0e <0f> b6 04 0f 3
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 06 (bad)
1: 48 39 07 cmp %rax,(%rdi)
4: 75 17 jne 0x1d
6: 48 83 c7 08 add $0x8,%rdi
a: 48 83 c6 08 add $0x8,%rsi
e: 48 83 ea 08 sub $0x8,%rdx
12: 48 83 fa 07 cmp $0x7,%rdx
16: 77 e6 ja 0xfffffffffffffffe
18: 48 85 d2 test %rdx,%rdx
1b: 74 20 je 0x3d
1d: 31 c9 xor %ecx,%ecx
1f: eb 09 jmp 0x2a
21: 48 83 c1 01 add $0x1,%rcx
25: 48 39 ca cmp %rcx,%rdx
28: 74 0e je 0x38
2a:* 0f b6 04 0f movzbl (%rdi,%rcx,1),%eax <-- trapping instruction
2e: 03 .byte 0x3

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 0f b6 04 0f movzbl (%rdi,%rcx,1),%eax
4: 03 .byte 0x3
[ 39.843315][T10850] RSP: 0018:ffff888130933990 EFLAGS: 00010246
[ 39.844231][T10850] RAX: 0000000000000000 RBX: ffff88810dfe5000 RCX:
0000000000000000
[ 39.845431][T10850] RDX: 0000000000000004 RSI: ffffffff863584a0 RDI:
ffff88810dfe5000
[ 39.846664][T10850] RBP: ffff888130933a50 R08: ffff88812f519fe4 R09:
0000000000000001
[ 39.847863][T10850] R10: 0000000000000012 R11: ffff888109b8be0c R12:
0000000000000000
[ 39.849014][T10850] R13: ffff888130933b0c R14: 0000000000000000 R15:
ffff88812f519000
[ 39.850245][T10850] FS: 00007f597daf8640(0000)
GS:ffff88823bf80000(0000) knlGS:0000000000000000
[ 39.851574][T10850] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 39.852590][T10850] CR2: ffff88810dfe5000 CR3: 000000012e65a000 CR4:
00000000000006f0
[ 39.853812][T10850] Call Trace:
[ 39.854297][T10850] <TASK>
[39.854757][T10850] ? show_regs
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/d=
umpstack.c:479)
[39.855431][T10850] ? __die
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/d=
umpstack.c:421
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/du=
mpstack.c:434)
[39.856046][T10850] ? page_fault_oops
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:711)
[39.856834][T10850] ? memcmp
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/string.c:676)
[39.857474][T10850] ? is_prefetch.constprop.0
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:171)
[39.858304][T10850] ? kernelmode_fixup_or_oops.constprop.0
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:738)
[39.859320][T10850] ? __bad_area_nosemaphore
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:787)
[39.860094][T10850] ? bad_area_nosemaphore
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:835)
[39.860772][T10850] ? exc_page_fault
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:1198
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.=
c:1479
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.=
c:1539)
[39.861412][T10850] ? __sanitizer_cov_trace_const_cmp4
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/kcov.c:316=
)
[39.862191][T10850] ? __filemap_get_folio
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:1982=
)
[39.862858][T10850] ? asm_exc_page_fault
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./arch/x86/includ=
e/asm/idtentry.h:623)
[39.863520][T10850] ? memcmp
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/string.c:676)
[39.864040][T10850] ? __build_id_parse.isra.0
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/buildid.c:309=
)
[39.864755][T10850] ? d_path
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/d_path.c:295)
[39.865301][T10850] ? should_failslab
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/failslab.c:46)
[39.865892][T10850] build_id_parse_nofault
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/buildid.c:339=
)
[39.866531][T10850] perf_event_mmap
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/events/cor=
e.c:8966
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/events/core=
.c:9104)
[39.867172][T10850] mmap_region
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/mmap.c:1533)
[39.867754][T10850] do_mmap
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/mmap.c:497)
[39.868279][T10850] vm_mmap_pgoff
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/util.c:588)
[39.868902][T10850] ksys_mmap_pgoff
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/mmap.c:542)
[39.869500][T10850] __x64_sys_mmap
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/s=
ys_x86_64.c:86
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/sy=
s_x86_64.c:79
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/sy=
s_x86_64.c:79)
[39.870079][T10850] x64_sys_call
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/sy=
scall_64.c:36)
[39.870717][T10850] do_syscall_64
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/co=
mmon.c:52
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/com=
mon.c:83)
[39.871325][T10850] entry_SYSCALL_64_after_hwframe
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/en=
try_64.S:130)
[ 39.872205][T10850] RIP: 0033:0x7f597cd9c62d
[ 39.872840][T10850] Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 8
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 02 b8 ff ff ff ff add -0x1(%rax),%bh
6: c3 ret
7: 66 0f 1f 44 00 00 nopw 0x0(%rax,%rax,1)
d: f3 0f 1e fa endbr64
11: 48 89 f8 mov %rdi,%rax
14: 48 89 f7 mov %rsi,%rdi
17: 48 89 d6 mov %rdx,%rsi
1a: 48 89 ca mov %rcx,%rdx
1d: 4d 89 c2 mov %r8,%r10
20: 4d 89 c8 mov %r9,%r8
23: 4c 8b 4c 24 08 mov 0x8(%rsp),%r9
28: 0f 05 syscall
2a:* 48 rex.W <-- trapping instruction
2b: 3d .byte 0x3d
2c: 01 f0 add %esi,%eax
2e: 08 .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 48 rex.W
1: 3d .byte 0x3d
2: 01 f0 add %esi,%eax
4: 08 .byte 0x8
[ 39.875549][T10850] RSP: 002b:00007f597daf7f98 EFLAGS: 00000246
ORIG_RAX: 0000000000000009
[ 39.876779][T10850] RAX: ffffffffffffffda RBX: 00007f597cf65f80 RCX:
00007f597cd9c62d
[ 39.877906][T10850] RDX: 0000000000000001 RSI: 0000000000003000 RDI:
0000000020ffa000
[ 39.879059][T10850] RBP: 00007f597ce264d3 R08: 0000000000000004 R09:
000000005e0a6000
[ 39.880197][T10850] R10: 0000000000000011 R11: 0000000000000246 R12:
0000000000000000
[ 39.881296][T10850] R13: 0000000000000000 R14: 00007f597cf65f80 R15:
00007f597dad8000
[ 39.882408][T10850] </TASK>
[ 39.882854][T10850] Modules linked in:
[ 39.883421][T10850] CR2: ffff88810dfe5000
[ 39.884011][T10850] ---[ end trace 0000000000000000 ]---
[39.884778][T10850] RIP: 0010:memcmp
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/string.c:676)
[ 39.885442][T10850] Code: 06 48 39 07 75 17 48 83 c7 08 48 83 c6 08
48 83 ea 08 48 83 fa 07 77 e6 48 85 d2 74 20 31 c9 eb 09 48 83 c1 01
48 39 ca 74 0e <0f> b6 04 0f 3
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 06 (bad)
1: 48 39 07 cmp %rax,(%rdi)
4: 75 17 jne 0x1d
6: 48 83 c7 08 add $0x8,%rdi
a: 48 83 c6 08 add $0x8,%rsi
e: 48 83 ea 08 sub $0x8,%rdx
12: 48 83 fa 07 cmp $0x7,%rdx
16: 77 e6 ja 0xfffffffffffffffe
18: 48 85 d2 test %rdx,%rdx
1b: 74 20 je 0x3d
1d: 31 c9 xor %ecx,%ecx
1f: eb 09 jmp 0x2a
21: 48 83 c1 01 add $0x1,%rcx
25: 48 39 ca cmp %rcx,%rdx
28: 74 0e je 0x38
2a:* 0f b6 04 0f movzbl (%rdi,%rcx,1),%eax <-- trapping instruction
2e: 03 .byte 0x3

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 0f b6 04 0f movzbl (%rdi,%rcx,1),%eax
4: 03 .byte 0x3
[ 39.888119][T10850] RSP: 0018:ffff888130933990 EFLAGS: 00010246
[ 39.888991][T10850] RAX: 0000000000000000 RBX: ffff88810dfe5000 RCX:
0000000000000000
[ 39.890114][T10850] RDX: 0000000000000004 RSI: ffffffff863584a0 RDI:
ffff88810dfe5000
[ 39.891243][T10850] RBP: ffff888130933a50 R08: ffff88812f519fe4 R09:
0000000000000001
[ 39.892382][T10850] R10: 0000000000000012 R11: ffff888109b8be0c R12:
0000000000000000
[ 39.893467][T10850] R13: ffff888130933b0c R14: 0000000000000000 R15:
ffff88812f519000
[ 39.894608][T10850] FS: 00007f597daf8640(0000)
GS:ffff88823bf80000(0000) knlGS:0000000000000000
[ 39.895880][T10850] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 39.896821][T10850] CR2: ffff88810dfe5000 CR3: 000000012e65a000 CR4:
00000000000006f0
[ 39.897961][T10850] Kernel panic - not syncing: Fatal exception
[ 39.899085][T10850] Kernel Offset: disabled
[ 39.899598][T10850] Rebooting in 86400 seconds..

