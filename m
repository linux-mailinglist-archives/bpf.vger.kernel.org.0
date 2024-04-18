Return-Path: <bpf+bounces-27104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410198A9152
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 04:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA871282BE4
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 02:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9419E51C5E;
	Thu, 18 Apr 2024 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N2fkdxBf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="isgkEJXE"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239255244;
	Thu, 18 Apr 2024 02:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713408783; cv=fail; b=YrhoR3RjV5fKA/nJEWa+Z65+pHsJqYxMJ31xMttuqP0YtYVIpLF4YeSIwQDyfOOMptOOxCLfymyx9JQlW6eD4C3BxfXD4EyyI83hNmOl8obte6Nm+jGNMt+WAZGXPb09zitJ+dk3Ee6KcCFEd68JkbWJt11Mw32fia1wrvFz91k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713408783; c=relaxed/simple;
	bh=l61V2fhCa0oysvLnNQE017ld2lHPk3lhnaSIsNsTTYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ad3Gnl6QGISAZzA03jLOsZ2q6T6p7mwzxDAT0qjg8tW2pT+9u6kVLeJB1Va2dXFQfANttNOn+eFg+40UnKjdb6YCYfK0ceqimgsH14P3oRIQ2Twxm84HHZ9dJPCmSY2u0KeqtVQtGbQPfpFWaTC2T+Oi2ropQVlMseGaxGuHFyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N2fkdxBf; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=isgkEJXE; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c1b2165efd2e11eeb8927bc1f75efef4-20240418
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=l61V2fhCa0oysvLnNQE017ld2lHPk3lhnaSIsNsTTYk=;
	b=N2fkdxBfwXf6A7TbzGTY983PAKLNi7TJKIQi+MRA5wbP0tZmQzpqkowtMym7U6B3Ylju25QEJFrcQs/WpZHfVssOCyPiJ0TCk5zgduCTV9m0BPalh61woKQFSKREsoUgPB8BWCPb8ZCv97CnHUHspdVYVTKVggornWQK/wzfbo8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7ec5fb07-c536-492d-b4dc-76da9ac77d40,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:62a3b691-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c1b2165efd2e11eeb8927bc1f75efef4-20240418
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1776635191; Thu, 18 Apr 2024 10:52:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Apr 2024 19:52:54 -0700
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 Apr 2024 10:52:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2XaaXS5/UkhqFZNMza+7bkl3ejsxYsz/4tn6pkGGk9fbUA4qbOiC2U3EdHDnaDplC27Cb6M+MByoW5U9WxZv0m5Xk/o7hy8K0hrM12ZI62SyGZ3DQdIBOi7nT7mzsRE+nRKuzV8XIJhGe3TrMB0PyyRtBNQujPsMN6VjwYF/CE9JW6DQ9Bt6N3khOwtBrAwwk0uxwYn9hC48+hQXrAfOOnwjSWiJBTohPPYw2gWx9zj7FdZYhj4z49k20Gwlcwe1VD9ptv9+GVNmdP9hEvPAZ7AfhE2r6adI/a3eAPbmPwKGBsQbbF1RFcZ6gAX8fctqPRVT3tw/gPbCFfaiYgw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l61V2fhCa0oysvLnNQE017ld2lHPk3lhnaSIsNsTTYk=;
 b=UoyEdHfH44DPA5EgSiOg6D21bHOVnKsO4BNw4BpwTJxaZcgLaGS83VIMnZurT6klI49GdBqPl0hZQHdOo3z+tMePKDOBkY+XmX16PnRf9AswOTPyvCmKD0d//SWvJmNkrvthPCTYqIt1VMhZo3CJiuJhaue7VR0kdK2LW6yP/+EwRxH/2cCDx51YeUTdfhDA2R3F3uD77tmR/8qc38YXWKOcfi6itvHC7P+MijppS/wzINn+UQUDBqv1dU63mwP8ANSCulglUxWTi0HmAC5C2jOvPc6ebsAfOzKriOtBAnzvC/MqgiCkNmJMbMeQCOrgxpwteGsouq08n+IMLwKXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l61V2fhCa0oysvLnNQE017ld2lHPk3lhnaSIsNsTTYk=;
 b=isgkEJXEmda9iPNTgcw2r8Fg8Z8Ai1lu4rf8TBI2ts56HKhrU3C22i9a1XhUsaz9722LQ0c3bi8SiSOoxXVuXoeYwdJEqkHn5re3huin4XJ0OsWHJXLiASomOpsv8ggoP5PdxMDnORwJ2EQJdW0caZFLBY+Hv7VhXx6NpPESyyQ=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by TYZPR03MB8168.apcprd03.prod.outlook.com (2603:1096:400:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 02:52:52 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7%6]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 02:52:52 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "maze@google.com" <maze@google.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "kuba@kernel.org" <kuba@kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Thread-Topic: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Thread-Index: AQHaj0XOIxnbbRpuOEqwUbC2K0Us3rFpz0sAgABZ6oCAAArbAIAA8PYAgAAJ3wCAAAGxgIAAWJUAgACHpICAANEgAIAAdp6A
Date: Thu, 18 Apr 2024 02:52:52 +0000
Message-ID: <11395231f8be21718f89981ffe3703da3f829742.camel@mediatek.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
	 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
	 <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
	 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
	 <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch>
	 <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
	 <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
	 <661f066060ab4_7a39f2945d@willemb.c.googlers.com.notmuch>
	 <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
	 <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch>
In-Reply-To: <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|TYZPR03MB8168:EE_
x-ms-office365-filtering-correlation-id: 3056ca64-20b1-4ebf-96c0-08dc5f52a415
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?ZTdySEM1MVRhQVp2UEFqcUJXeHk5SmNCOXhGYnJjZzVPZW5ZWHVtLzFSSVBw?=
 =?utf-8?B?RE9CSU40MEJOS3RQSEV3VzJ4Z1NjM1ZEQWx3a0JzU0YrTjZ3TFVkT2JUUjJV?=
 =?utf-8?B?V3dVNWZTZUZsS1BBNkR6cHFNeU5Ca3ByNWUxL1piUDhIU29JZGFqN2JhZjNS?=
 =?utf-8?B?d2RmOVhLQ3dYWEZXUTVBMUpZMXpvVzMyUllNTjhaWnhzeDZ4WlJXQXl4YVI2?=
 =?utf-8?B?OVR0dWdTeU1PN3ZBWGlhMTRTUHo4bm4xS1JySjUwcVkxazYxdG5NV25wSThW?=
 =?utf-8?B?bU5WS2pGM3owbjByVWpya2Jhd2pQbWx4NFI0L1VrSlN0Vnk4UFFlQXpJUHhX?=
 =?utf-8?B?bVRRN0dFZWdkMUxhUjI5MzVFM2RKZjVSWUJIT1lYa2Z2QjRXWmlRMUl2ZjB2?=
 =?utf-8?B?cURYVmxZZ21iS3pya2E3b0lpUjhkcEdlanYybUJodnMrT2JOMXZXWlUzNFV1?=
 =?utf-8?B?NEsyQmoyZllrTDdWN3hGWGhoM0JrRGlyUUE3QnovdnMrRkx0ZGNhZHkvVitQ?=
 =?utf-8?B?eTQ0VXBQYnRKWVMwcjROMVFHLzFnSERwVDdoTy9VRVAydU12UUtDaWNPR3VO?=
 =?utf-8?B?elZtV2h0YzhLbVREVS9SVmdYck1TRlVGcVlXRVpUSWt2UlJPUWJMbXg3NzhY?=
 =?utf-8?B?WFNYWlVTeUZQNHBTdGw0NWZvNmxwRHVHRmtDNXZSUmdlZHJXUFVGOTY3dU1D?=
 =?utf-8?B?Wk5PZTdRcWMxMEUrNENRak9yN0NCMmszWmRzQzJhUkQ4aHJsWHhOY29EOWww?=
 =?utf-8?B?NW55ci9LTVFrNC9ydzBRZjVrZlpWTGRyQncvaFdLQlpjbFpZRytuSnVMUFor?=
 =?utf-8?B?a2x5UEhYb2NIcGd2ZU9rdWt4b1NDSldFWWtQWmgwKzcvUFhYWFZQUWIxMnBS?=
 =?utf-8?B?UGNvMi80ckI4UEhRWjM5SFRmbGgrU2Vya3JBcnYrL1ovN3VKekdkYnNrZ3R5?=
 =?utf-8?B?dWtuVE9GQlJQcklJeVRnbGd5eEUzbHh5VGpZamxCNXJDSllGUWMxZGVEaFBH?=
 =?utf-8?B?dWM2dEtmUTBEbm1CR28yamlvVlBnWmYxcE5LQndpaTFmdkhyMXFIR3d4MG4y?=
 =?utf-8?B?dXBVcEg1TWppR0ppZVpyUDZxaG41T3BpTXZMMEM0ZW5kdnlrb3VqTXdIZHhz?=
 =?utf-8?B?YTdaaittYlJsbnNpeEtGWVRUTjJ0ZS9TTkZaSnZMQkFHQjlCaWpRVmxyZ3VJ?=
 =?utf-8?B?NmdqSnVvS0oxTFE5S0E5YlN0WXU0Zno4aCszVTNCV1pFZGNiMFR4YytvRnhR?=
 =?utf-8?B?eFBNZ05kYkFYQnJBakZNcElkUVh6aTk1THpFd2tnUVVoU3J3eDVyd1lQc1FT?=
 =?utf-8?B?RTI3eXo2VVhrQ0dvTlBwSjFFdnRjVVhWb2Z3UzJmUGdzU1R3T1JoaVRFTVpW?=
 =?utf-8?B?UUY3YjhjODkrUGZHTWVFcmlvaDVMWXE2VWZKb2NEaW9tNlo0dElMQ3NtaC9r?=
 =?utf-8?B?eEREcGpGT1dnM2ZoMVBPck53L0NLMW5KemE2emdiL3hFb1NyeFI1TXlBdkJ3?=
 =?utf-8?B?ek9lZDhEMm80M0pVK2l4NDYwY2FFZmZiZWdEd21wSFhIVFN0T0RDenFuN2tD?=
 =?utf-8?B?bVhyemhPVzcxNEZnSVVGQVk5RVZOZFV3T1BMTlV1WXhlcDIyNnNGSTdLRnVn?=
 =?utf-8?B?OStoWEQrZG5SWUR5aFFPNDhqa2p6dENqNEhDajBSQUxqcUFtSHN3OUdKV25M?=
 =?utf-8?B?eVNWZm1XbHc5dXE3NFFBQUJXVnlrbldPam04b3R5RXdyMC9QNENEOEwybkky?=
 =?utf-8?B?cnNhVy9EOTkvcHBVS0VwMm9pc1lVYVhQdmNWRWNScFIydHd6NTE0VHRydnZR?=
 =?utf-8?B?UzUwckI0RC9qaThBYTIxdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnQya0VlU0pBMGxpdkhSUGNucVZzLzVRNnN4UGJ5RnpoTjZBSGFLa01SWUJQ?=
 =?utf-8?B?T1crN1VEUDV3TFpxWUlRT1J2RjgvTlJ1eFB1SC9YK2F5VkxKd0JyMGRhbjAx?=
 =?utf-8?B?am4rU2lrS2lWZXNldWtvVytFaDY2TitRTXZWakV5VHk5b3JmaEJHUEZ3djlN?=
 =?utf-8?B?OGZxeWlyMUwyZG9rdFpxQk1iaVExQUxMOW9laGo3V0dhMUdVWUVabFU4SHQx?=
 =?utf-8?B?V2gwWmsycmdUdlFXeDQ5MXR0S0x4MzBPeml5bXM4SVNOSUVlckk5cVZtMjhm?=
 =?utf-8?B?aUpOb1hLMXpTMGJUeXA5K09GdGJOVVJ5R1JtNXhhNTdPRFpDd1MyRjJHaVZH?=
 =?utf-8?B?VHZscTM3MWd3WkhBZWxuck1KeC9BQjF0VHFGUFUwVndob01BZlhzRkpBQUJS?=
 =?utf-8?B?ZFMrNHFTV0JGQ0sxTWlEeGVHUzY5QnhaQjhpQ09LbTVCSXlJWis0eGNsL2d5?=
 =?utf-8?B?eDJMMnZHRVNtckZYNW5kNnIwWlB6d2Z0aEFFWlovcTEyeEw1UmRYcWd4cnlL?=
 =?utf-8?B?QnllekVpYTgzQVNSY2FJa0xGTFpwSFU4V1NHQlBZTEoyL1lEOHlxN2NqNWo3?=
 =?utf-8?B?SkNYN1VxcTBxMXVrbkpSMmtLWlpqMUVEVFZXcitGRFYxK0dleXBsczB2U3Fp?=
 =?utf-8?B?bTNiSHNkaGVmMlNKd0VDd1lyK0NzUWp6OEhmL0U4c0lQcW9EZHRzcnRQVW9O?=
 =?utf-8?B?YlVlNEc0blo0dGxuTFdldTlJeXhKU3pycXJVQ2VvaW5HSTdwdjV3U3JwU21G?=
 =?utf-8?B?aWE1K3BuSlVOMHpuSWNQdnNnRnR4cnlHM2oxRXpwc2g5NjVYK0tWWFRVV3lF?=
 =?utf-8?B?eGpQSXRGNldEZWRDUDlYdkZjdzVMeGtBRXIvQmpkRWVlYTJRQitTOXBJWEg4?=
 =?utf-8?B?RlB3NlRxRHNsNWhINDZJVEFuWkwyTk1FdjdsU1lXTzRJZVhZUCt1bE1XQmts?=
 =?utf-8?B?SVphTDhYTFk5VktFcStpK2JTcE80d01lUHdMYlFTM3FkUkw4OEVBaEZtbmxU?=
 =?utf-8?B?RHB3ZXlsUFJHcFR3VkRHZFhrTkJKUzF3WGtIR2wrMjVPclkwSXY5SnA1blFB?=
 =?utf-8?B?S2JUUjZ2UHlHalFXVXB5NE9VNTROVGV0QXVhMXo0SjFvamx1UXpPMkRzZkpO?=
 =?utf-8?B?OGZWcmhrNjVzSEo3VnBId2hmdGJHaUVobFgyQnI0VTlFR3FkYWsvSTNmb2Zr?=
 =?utf-8?B?cVd5WStCdTBHaDdKRk9MRHFCdnZRZGFxL2ZiR200UXI3ZlkvRWZtbDcrU0or?=
 =?utf-8?B?ajcrSTRycXVtM0VwSmVRbElpV3ZNemlHSUdjbDdyY3ZzVExxZC8ySTJGQ003?=
 =?utf-8?B?Q2xsWkdNd1FKait3bVZzWlpFMi8zTEZ0Vmt2ZEFHL2huY0k1czBFQ3d2TSs1?=
 =?utf-8?B?U2V3K2JsUEdSOXFlSjBPdmVUakJNRyt4SXZvYURxT21yTTFVVUJDUnZOT0lJ?=
 =?utf-8?B?aHJxbWluNHgwQXdKeTJVZVhza2hUaksyTVlkTmh1emhmY3ZnNXk4TWJ4Q0xK?=
 =?utf-8?B?a2orVU8yRUFZeUZhMUp1VUJsc0l1blViRXF0aytPZzlIVXB4M3g1Y1h0dGs1?=
 =?utf-8?B?Wk55MDVHK1lPVWhsc0VTdzloY0R3TVlFUUowUkZVMnRHZkxMUW1RYnYxc1NT?=
 =?utf-8?B?OGs0Zk1meG1nODh3MUdQVWlwRzd0bXRVUTZOQ1dSOGFuVkcwOTExTDAyT05D?=
 =?utf-8?B?WVVib3FMNWpYNTlnYVp1ZGlrUDhqekJkRW5PRnMwS2I1aVgzaGtWN0VmMngr?=
 =?utf-8?B?b0l6YmVadFJPcnNLYThvczNUM3YvSTdSWnlidSthUzZnQWJFbGxGT1o3endt?=
 =?utf-8?B?R0lmb3JUN21IMENOUmhZamNXMlVFaWtVRy9zakFKSGRlT1BTNC9VeitvNXl4?=
 =?utf-8?B?cDE1VUg5Q1hPb2RlSTZJZ3l3QTJKWWJDclBmMXBWTEtoSnRtZVE5bzYvZ1Vu?=
 =?utf-8?B?dmc2NjhCbnA5Z2JxUllXTUFzeEpqbEQ3N3VKL1RXM2hVdjArOHlpY1RpYWV5?=
 =?utf-8?B?VE1EL0JuaWp2VW9HVUNvVTlvUFQ0U0JaRnp1T2hGd2hGSGU4WjNXOXR4cE1R?=
 =?utf-8?B?ZmFpOGJmK2NhbVJ2WVpTN3hPeEVPamdIWW1jWGlhRzNkcU9UTmFyODVORGJU?=
 =?utf-8?B?U2R0WVJleU5BMkV4UmdMRm1DVXpHQXlGandBT2lDb2tnUHllUm5RNitaeG56?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E59A6950DCC0C459558473F20BDA3A6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3056ca64-20b1-4ebf-96c0-08dc5f52a415
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 02:52:52.4547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHzlzBPl2/d7uyqywVieW3jRClIZ8aMoDPiu45IViYthcP0Orl6STWl3Lyh91w/hih1bitJZrJqrQHz1j+7TRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8168

T24gV2VkLCAyMDI0LTA0LTE3IGF0IDE1OjQ4IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIExlbmEgV2FuZyAo546L5aicKSB3cm90ZToNCj4gPiBPbiBUdWUs
IDIwMjQtMDQtMTYgYXQgMTk6MTQgLTA0MDAsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6DQo+ID4g
PiAgIA0KPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMNCj4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBz
ZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiAgPiA+ID4gPiBQZXJzb25hbGx5LCBJIHRoaW5r
IGJwZl9za2JfcHVsbF9kYXRhKCkgc2hvdWxkIGhhdmUNCj4gPiA+IGF1dG9tYXRpY2FsbHkNCj4g
PiA+ID4gPiA+ID4gKGllLiBpbiBrZXJuZWwgY29kZSkgcmVkdWNlZCBob3cgbXVjaCBpdCBwdWxs
cyBzbyB0aGF0IGl0DQo+ID4gPiB3b3VsZCBwdWxsDQo+ID4gPiA+ID4gPiA+IGhlYWRlcnMgb25s
eSwNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGF0IHdvdWxkIGJlIGEgaGVscGVyIHRoYXQg
cGFyc2VzIGhlYWRlcnMgdG8gZGlzY292ZXINCj4gaGVhZGVyDQo+ID4gPiBsZW5ndGguDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBEb2VzIGl0IGFjdHVhbGx5IG5lZWQgdG8/ICBQcmVzdW1hYmx5IHRo
ZSBicGYgcHVsbCBmdW5jdGlvbg0KPiBjb3VsZA0KPiA+ID4gPiA+IG5vdGljZSB0aGF0IGl0IGlz
DQo+ID4gPiA+ID4gYSBwYWNrZXQgZmxhZ2dlZCBhcyBiZWluZyBvZiB0eXBlIFggKFVEUCBHU08g
RlJBR0xJU1QpIGFuZA0KPiByZWR1Y2UNCj4gPiA+IHRoZSBwdWxsDQo+ID4gPiA+ID4gYWNjb3Jk
aW5nbHkgc28gdGhhdCBpdCBkb2Vzbid0IHB1bGwgYW55dGhpbmcgZnJvbSB0aGUgbm9uLQ0KPiBs
aW5lYXINCj4gPiA+ID4gPiBmcmFnbGlzdCBwb3J0aW9uPz8/DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBJIGtub3cgb25seSB0aGUgZ2VuZXJpYyBvdmVydmlldyBvZiB3aGF0IHVkcCBnc28gaXMsIG5v
dCBhbnkNCj4gPiA+IGRldGFpbHMsIHNvIEkgYW0NCj4gPiA+ID4gPiBhc3N1bWluZyBoZXJlIHRo
YXQgdGhlcmUncyBzb21lIHNvcnQgb2YgZ3VhcmFudGVlIHRvIGhvdw0KPiB0aGVzZQ0KPiA+ID4g
cGFja2V0cw0KPiA+ID4gPiA+IGFyZSBzdHJ1Y3R1cmVkLi4uICBCdXQgSSBpbWFnaW5lIHRoZXJl
IG11c3QgYmUgb3Igd2Ugd291bGRuJ3QNCj4gYmUNCj4gPiA+IGhpdHRpbmcgdGhlc2UNCj4gPiA+
ID4gPiBpc3N1ZXMgZGVlcGVyIGluIHRoZSBzdGFjaz8NCj4gPiA+ID4gDQo+ID4gPiA+IFBlcmhh
cHMgZm9yIGEgcGFja2V0IG9mIHRoaXMgdHlwZSB3ZSdyZSBhbHJlYWR5IGd1YXJhbnRlZWQgdGhl
DQo+ID4gPiBoZWFkZXJzDQo+ID4gPiA+IGFyZSBpbiB0aGUgbGluZWFyIHBvcnRpb24sDQo+ID4g
PiA+IGFuZCB0aGUgcHVsbCBzaG91bGQgc2ltcGx5IGJlIGlnbm9yZWQ/DQo+ID4gPiA+IA0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBQYXJzaW5nIGlzIGJldHRlciBsZWZ0IHRvIHRoZSBCUEYgcHJv
Z3JhbS4NCj4gPiA+IA0KPiA+ID4gSSBkbyBwcmVmZXIgYWRkaW5nIHNhbml0eSBjaGVja3MgdG8g
dGhlIEJQRiBoZWxwZXJzLCBvdmVyIGhhdmluZw0KPiB0bw0KPiA+ID4gYWRkIHRoZW4gaW4gdGhl
IG5ldCBob3QgcGF0aCBvbmx5IHRvIHByb3RlY3QgYWdhaW5zdCBkYW5nZXJvdXMNCj4gQlBGDQo+
ID4gPiBwcm9ncmFtcy4NCj4gPiA+IA0KPiA+IElzIGl0IE9LIHRvIGlnbm9yZSBvciBkZWNyZWFz
ZSBwdWxsIGxlbmd0aCBmb3IgdWRwIGdybyBmcmFnbGlzdA0KPiBwYWNrZXQ/DQo+ID4gSXQgY291
bGQgc2F2ZSB0aGUgbm9ybWFsIHBhY2tldCBhbmQgc2VudCB0byB1c2VyIGNvcnJlY3RseS4NCj4g
PiANCj4gPiBJbiBjb21tb24vbmV0L2NvcmUvZmlsdGVyLmMNCj4gPiBzdGF0aWMgaW5saW5lIGlu
dCBfX2JwZl90cnlfbWFrZV93cml0YWJsZShzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiA+ICAgICAg
ICAgICAgICAgdW5zaWduZWQgaW50IHdyaXRlX2xlbikNCj4gPiB7IA0KPiA+ICtpZiAoc2tiX2lz
X2dzbyhza2IpICYmIChza2Jfc2hpbmZvKHNrYiktPmdzb190eXBlICYNCj4gPiArKFNLQl9HU09f
VURQICB8U0tCX0dTT19VRFBfTDQpKSB7DQo+IA0KPiBUaGUgaXNzdWUgaXMgbm90IHdpdGggU0tC
X0dTT19VRFBfTDQsIGJ1dCB3aXRoIFNLQl9HU09fRlJBR0xJU1QuDQo+IA0KQ3VycmVudCBpbiBr
ZXJuZWwganVzdCBVRFAgdXNlcyBTS0JfR1NPX0ZSQUdMSVNUIHRvIGRvIEdSTy4gSW4NCnVkcF9v
ZmZsb2FkLmMgdWRwNF9ncm9fY29tcGxldGUgZ3NvX3R5cGUgYWRkcyAiU0tCX0dTT19GUkFHTElT
VHwNClNLQl9HU09fVURQX0w0Ii4gSGVyZSBjaGVja2luZyB0aGVzZSB0d28gZmxhZ3MgaXMgdG8g
bGltaXQgdGhlIHBhY2tldA0KYXMgIlVEUCArIG5lZWQgR1NPICsgZnJhZ2xpc3QiLg0KDQpXZSBj
b3VsZCByZW1vdmUgU0tCX0dTT19VRFBfTDQgY2hlY2sgZm9yIG1vcmUgcGFja2V0IHRoYXQgbWF5
IGFkZHJpdmUNCnNrYl9zZWdtZW50X2xpc3QuDQoNCj4gPiArcmV0dXJuIDA7DQo+IA0KPiBGYWls
aW5nIGZvciBhbnkgcHVsbCBpcyBhIGJpdCBleGNlc3NpdmUuIEFuZCB3b3VsZCBraWxsIGEgc2Fu
ZQ0KPiB3b3JrYXJvdW5kIG9mIHB1bGxpbmcgb25seSBhcyBtYW55IGJ5dGVzIGFzIG5lZWRlZC4N
Cj4gIA0KPiA+ICsgICAgIG9yIGlmICh3cml0ZV9sZW4gPiBza2JfaGVhZGxlbihza2IpKQ0KPiA+
ICt3cml0ZV9sZW4gPSBza2JfaGVhZGxlbihza2IpOw0KPiANCj4gVHJ1bmNhdGluZyByZXF1ZXN0
cyB3b3VsZCBiZSBhIHN1cnByaXNpbmcgY2hhbmdlIG9mIGJlaGF2aW9yDQo+IGZvciB0aGlzIGZ1
bmN0aW9uLg0KPiANCj4gRmFpbGluZyBmb3IgYSBwdWxsID4gc2tiX2hlYWRsZW4gaXMgYXJndWFi
bHkgcmVhc29uYWJsZSwgYXMNCj4gdGhlIGFsdGVybmF0aXZlIGlzIHRoYXQgd2UgbGV0IGl0IGdv
IHRocm91Z2ggYnV0IGhhdmUgdG8gZHJvcA0KPiB0aGUgbm93IG1hbGZvcm1lZCBwYWNrZXRzIG9u
IHNlZ21lbnRhdGlvbi4NCj4gDQo+IA0KSXMgaXQgT0sgYXMgYmVsb3c/DQoNCkluIGNvbW1vbi9u
ZXQvY29yZS9maWx0ZXIuYw0Kc3RhdGljIGlubGluZSBpbnQgX19icGZfdHJ5X21ha2Vfd3JpdGFi
bGUoc3RydWN0IHNrX2J1ZmYgKnNrYiwNCiAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHdyaXRl
X2xlbikNCnsgDQorICAgICAgIGlmIChza2JfaXNfZ3NvKHNrYikgJiYgKHNrYl9zaGluZm8oc2ti
KS0+Z3NvX3R5cGUgJg0KKyAgICAgICAgICAgICAgIFNLQl9HU09fRlJBR0xJU1QpICYmICh3cml0
ZV9sZW4gPiBza2JfaGVhZGxlbihza2IpKSkgew0KKyAgICAgICAgICAgICAgIHJldHVybiAwOw0K
KyAgICAgICB9DQogICAgICAgIHJldHVybiBza2JfZW5zdXJlX3dyaXRhYmxlKHNrYiwgd3JpdGVf
bGVuKTsNCn0NCg0KPiA+ICt9DQo+ID4gcmV0dXJuIHNrYl9lbnN1cmVfd3JpdGFibGUoc2tiLCB3
cml0ZV9sZW4pOw0KPiA+IH0NCj4gPiAgDQo+ID4gDQo+ID4gPiBJbiB0aGlzIGNhc2UsIGl0IHdv
dWxkIGJlIGRldGVjdGluZyB0aGlzIEdTTyB0eXBlIGFuZCBmYWlsaW5nIHRoZQ0KPiA+ID4gb3Bl
cmF0aW9uIGlmIGV4Y2VlZGluZyBza2JfaGVhZGxlbigpLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ID4gYW5kIG5vdCBwYWNrZXQgY29udGVudC4NCj4gPiA+ID4gPiA+ID4gKFRoaXMgaXMgYXNz
dW1pbmcgdGhlIHJlc3Qgb2YgdGhlIGNvZGUgaXNuJ3QgcmVhZHkgdG8NCj4gZGVhbA0KPiA+ID4g
d2l0aCBhIGxvbmdlciBwdWxsLA0KPiA+ID4gPiA+ID4gPiB3aGljaCBJIHRoaW5rIGlzIHRoZSBj
YXNlIGF0bS4gIFB1bGxpbmcgdG9vIG11Y2gsIGFuZA0KPiB0aGVuDQo+ID4gPiBjcmFzaGluZyBv
ciBmb3JjaW5nDQo+ID4gPiA+ID4gPiA+IHRoZSBzdGFjayB0byBkcm9wIHBhY2tldHMgYmVjYXVz
ZSBvZiB0aGVtIGJlaW5nIG1hbGZvcm1lZA0KPiA+ID4gc2VlbXMgd3JvbmcuLi4pDQo+ID4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEluIGdlbmVyYWwgaXQgd291bGQgYmUgbmljZSBpZiB0aGVy
ZSB3YXMgYSB3YXkgdG8ganVzdA0KPiBzYXkNCj4gPiA+IHB1bGwgYWxsIGhlYWRlcnMuLi4NCj4g
PiA+ID4gPiA+ID4gKG9yIHBvc3NpYmx5IGFsbCBMMi9MMy9MNCBoZWFkZXJzKQ0KPiA+ID4gPiA+
ID4gPiBZb3UgaW4gZ2VuZXJhbCBuZWVkIHRvIHB1bGwgc3R1ZmYgKmJlZm9yZSogeW91J3ZlIGV2
ZW4NCj4gbG9va2VkDQo+ID4gPiBhdCB0aGUgcGFja2V0LA0KPiA+ID4gPiA+ID4gPiBzbyB0aGF0
IHlvdSBjYW4gbG9vayBhdCB0aGUgcGFja2V0LA0KPiA+ID4gPiA+ID4gPiBzbyBpdCdzIHJlbGF0
aXZlbHkgaGFyZC9hbm5veWluZyB0byBwdWxsIHRoZSBjb3JyZWN0DQo+IGxlbmd0aA0KPiA+ID4g
ZnJvbSBicGYNCj4gPiA+ID4gPiA+ID4gY29kZSBpdHNlbGYuDQo+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+ID4gPiA+IEJQRiBuZWVkcyB0byBtb2RpZnkgYSBwcm9wZXIgbGVuZ3RoIHRvIGRv
IHB1bGwNCj4gZGF0YS4NCj4gPiA+IEhvd2V2ZXIga2VybmVsDQo+ID4gPiA+ID4gPiA+ID4gPiA+
IHNob3VsZCBhbHNvIGltcHJvdmUgdGhlIGZsb3cgdG8gYXZvaWQgY3Jhc2ggZnJvbSBhDQo+IGJw
Zg0KPiA+ID4gZnVuY3Rpb24NCj4gPiA+ID4gPiA+ID4gPiA+IGNhbGwuDQo+ID4gPiA+ID4gPiA+
ID4gPiA+IEFzIHRoZXJlIGlzIG5vIHNwbGl0IGZsb3cgYW5kIGFwcCBtYXkgbm90IGRlY29kZQ0K
PiB0aGUNCj4gPiA+IG1lcmdlZCBVRFANCj4gPiA+ID4gPiA+ID4gPiA+IHBhY2tldCwNCj4gPiA+
ID4gPiA+ID4gPiA+ID4gd2Ugc2hvdWxkIGRyb3AgdGhlIHBhY2tldCB3aXRob3V0IGZyYWdsaXN0
IGluDQo+ID4gPiBza2Jfc2VnbWVudF9saXN0DQo+ID4gPiA+ID4gPiA+ID4gPiBoZXJlLg0KPiA+
ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBGaXhlczogM2ExMjk2YTM4ZDBj
ICgibmV0OiBTdXBwb3J0IEdSTy9HU08gZnJhZ2xpc3QNCj4gPiA+IGNoYWluaW5nLiIpDQo+ID4g
PiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNoaW1pbmcgQ2hlbmcgPA0KPiA+ID4gc2hp
bWluZy5jaGVuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IExlbmEgV2FuZyA8bGVuYS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiA+
ID4gLS0tDQo+ID4gPiA+ID4gPiA+ID4gPiA+ICBuZXQvY29yZS9za2J1ZmYuYyB8IDMgKysrDQo+
ID4gPiA+ID4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4g
PiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9uZXQvY29y
ZS9za2J1ZmYuYyBiL25ldC9jb3JlL3NrYnVmZi5jDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGluZGV4
IGI5OTEyNzcxMmU2Ny4uZjY4ZjI2NzliMDg2IDEwMDY0NA0KPiA+ID4gPiA+ID4gPiA+ID4gPiAt
LS0gYS9uZXQvY29yZS9za2J1ZmYuYw0KPiA+ID4gPiA+ID4gPiA+ID4gPiArKysgYi9uZXQvY29y
ZS9za2J1ZmYuYw0KPiA+ID4gPiA+ID4gPiA+ID4gPiBAQCAtNDUwNCw2ICs0NTA0LDkgQEAgc3Ry
dWN0IHNrX2J1ZmYNCj4gPiA+ICpza2Jfc2VnbWVudF9saXN0KHN0cnVjdA0KPiA+ID4gPiA+ID4g
PiA+ID4gc2tfYnVmZiAqc2tiLA0KPiA+ID4gPiA+ID4gPiA+ID4gPiAgaWYgKGVycikNCj4gPiA+
ID4gPiA+ID4gPiA+ID4gIGdvdG8gZXJyX2xpbmVhcml6ZTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gK2lmICghbGlzdF9za2IpDQo+ID4gPiA+ID4gPiA+ID4gPiA+
ICtnb3RvIGVycl9saW5lYXJpemU7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBUaGlzIHdvdWxkIGNhdGNoIHRoZSBjYXNlIHdoZXJlIHRoZSBlbnRpcmUg
ZGF0YSBmcmFnX2xpc3QNCj4gaXMNCj4gPiA+ID4gPiA+IGxpbmVhcml6ZWQsIGJ1dCBub3QgYSBw
c2tiX21heV9wdWxsIHRoYXQgb25seSBwdWxscyBpbiBwYXJ0DQo+IG9mDQo+ID4gPiB0aGUNCj4g
PiA+ID4gPiA+IGxpc3QuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRXZlbiB3aXRoIEJQRiBi
ZWluZyBwcml2aWxlZ2VkLCB0aGUga2VybmVsIHNob3VsZCBub3QgY3Jhc2gNCj4gaWYNCj4gPiA+
IEJQRg0KPiA+ID4gPiA+ID4gcHVsbHMgYSBGUkFHTElTVCBHU08gc2tiLg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IEJ1dCB0aGUgY2hlY2sgbmVlZHMgdG8gYmUgcmVmaW5lZCBhIGJpdC4gRm9y
IGEgVURQIEdTTw0KPiBwYWNrZXQsDQo+ID4gPiBJDQo+ID4gPiA+ID4gPiB0aGluayBnc29fc2l6
ZSBpcyBzdGlsbCB2YWxpZCwgc28gaWYgdGhlIGhlYWRfc2tiIGxlbmd0aA0KPiBkb2VzDQo+ID4g
PiBub3QNCj4gPiA+ID4gPiA+IG1hdGNoIGdzb19zaXplLCBpdCBoYXMgYmVlbiBtZXNzZWQgd2l0
aCBhbmQgc2hvdWxkIGJlDQo+IGRyb3BwZWQuDQo+ID4gPiA+ID4gPg0KPiA+IElzIGl0IE9LIGFz
IGJlbG93PyBJcyBpdCBPSyB0byBhZGQgbG9nIHRvIHJlY29yZCB0aGUgZXJyb3IgZm9yIGVhc3kN
Cj4gPiBjaGVja2luZyBpc3N1ZS4NCj4gPiANCj4gPiBJbiBuZXQvY29yZS9za2J1ZmYuYyBza2Jf
c2VnbWVudF9saXN0DQo+ID4gK3Vuc2lnbmVkIGludCBtc3MgPSBza2Jfc2hpbmZvKGhlYWRfc2ti
KS0+Z3NvX3NpemU7DQo+ID4gK2Jvb2wgZXJyX2xlbiA9IGZhbHNlOw0KPiA+IA0KPiA+ICtpZiAo
IG1zcyAhPSBHU09fQllfRlJBR1MgJiYgbXNzICE9IHNrYl9oZWFkbGVuKGhlYWRfc2tiKSkgew0K
PiA+ICtwcl9lcnIoInNrYiBpcyBkcm9wcGVkIGR1ZSB0byBtZXNzZWQgZGF0YS4gZ3NvIHNpemU6
JWQsDQo+ID4gK2hkcmxlbjolZCIsIG1zcywgc2tiX2hlYWRsZW4oaGVhZF9za2IpDQo+IA0KPiBT
dWNoIGxvZ3Mgc2hvdWxkIGFsd2F5cyBiZSByYXRlIGxpbWl0ZWQuIEJ1dCBubyBuZWVkIHRvIGxv
ZyBjYXNlcw0KPiB3aGVyZSB3ZSB3ZWxsIHVuZGVyc3Rvb2QgaG93IHdlIGdldCB0aGVyZS4NCj4g
DQo+IEkgd291bGQgc3RpY2sgd2l0aCBvbmUgYXBwcm9hY2g6IGVpdGhlciBpbiB0aGUgQlBGIGZ1
bmMgb3IgaW4NCj4gc2VnbWVudGF0aW9uLCBub3QgYm90aC4gQW5kIHRoZW4gSSBmaW5kIEJQRiBw
cmVmZXJhYmxlLCBhcyBleHBsYWluZWQNCj4gYmVmb3JlLg0KPiANCk9LLCB3ZSB0cnkgbWFrZSBh
IHBhdGNoIGluIEJQRiBmdW5jLg0KDQo+ID4gK2lmICghbGlzdF9za2IpDQo+ID4gK2dvdG8gZXJy
X2xpbmVhcml6ZTsNCj4gPiArZWxzZQ0KPiA+ICtlcnJfbGVuID0gdHJ1ZTsNCj4gPiArfQ0KPiA+
IA0KPiA+IC4uLg0KPiA+ICtpZiAoZXJyX2xlbikgew0KPiA+ICtnb3RvIGVycl9saW5lYXJpemU7
DQo+ID4gK30NCj4gPiANCj4gPiBza2JfZ2V0KHNrYik7DQo+ID4gLi4uDQo=

