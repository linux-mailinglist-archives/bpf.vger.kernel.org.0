Return-Path: <bpf+bounces-27917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6028B3536
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 12:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68BEFB2474B
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131811422C6;
	Fri, 26 Apr 2024 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C3LxGzIy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MCwgFgnO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A243513DDD5
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126870; cv=fail; b=tJKzokK8ivFWduz22aXWz2+HDQUphUu7I+QPqOKRZsPVPYYj/JNClb67sy/SbeA6z5cHsVmsjSjwGE3VebIhqQnJHLec2M999PDeFl8W10s7N0UZsQrqAplR7+4UJccVHtu0SXNK+IOwqOMOdAfzQN9yi9dq0CITWR3qf/CoyU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126870; c=relaxed/simple;
	bh=enik5gMzAFn9SYnLnZLYAEip7o4SOvFBETzRx8cU2Jg=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=lkPUkRzolpDjUiet6pvobuDUNGr86oBxB09Dmc1UN2T+wuVhoMxUE67mK7vmhHOMeNsDh7BsRDAgVu0IyvcY+WcnLcirvKCHKimzHl36iGEi+KuDZ1cLUGcuG3ZbFaD2ZkDvcay+IlMOcgy4rWTheFmOb9MOr3Z4ZqihmFYideY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C3LxGzIy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MCwgFgnO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8TSkG022627;
	Fri, 26 Apr 2024 10:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6eNtge/rUQfDBrd4diNzkUp67zuonoVvTmBGwqG6cdQ=;
 b=C3LxGzIyl23Xet8sMXlLOJqyFiNqXSaZwlfADBBs2SK9F/bwHGFC/gPYUz+8PZh9LsvR
 RRPtZpTuddfGrk05oXeeKIHLBTkX2ftCte/ITNqWuD6xSUdKMkYI8fEWU+fGVGwbVFJa
 mx547LQYOu38gzMaT8KzrdEbWL5K2kRDQF51GfnKSD6EkhapbahYvtMOsH2tQKob5WSh
 utF2XubgxHvBc5sLMH2x30LwDEv1zp2EsNPwY4fuHNj8j6q7Gr2gO6MgU6jtiXAzIKm3
 u2NTIfaeorqHpQn+Nvd98r1jkYAIyRtW/8w2jY4c6/4NVaMsI4ql4NJb0tyOg2gsJc3o DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4mddtd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 10:20:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8Wrdp030873;
	Fri, 26 Apr 2024 10:20:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45bhb5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 10:20:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3TxxSTzrw0IhOqbDhQg0xEP0wsEqCV8e+ivKfMMmBc0HznN//o6wWP/MUTYi7tmb1/sJ7UdvTXuinIJEEsuxdvP/E8AkOT7iQdAxvBbr0QWmtzIbQUY/FF63DIR20dbB0/ng6A/o4+p76YwHlIOnHhv2FpPha9EolKoFgF8tcoXOFO89KxjQgSPDpoykR/FtO5xojESCoqCc5KLUnCRTUgmhhonSXCs1qxNg2porCVLo9WDd+XP5Z+6XDL41DEY5+XVSi/aw54pE3ytoDyScGojTxlR7CCL9JwN/E9Efe76RPMij1UhrpR+gAVoEv6A3465m/wJCpdkLNbn0eXNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eNtge/rUQfDBrd4diNzkUp67zuonoVvTmBGwqG6cdQ=;
 b=DNFv12V7BKx4vjoVt4G0aSwyfNuLQIWuVSzXkjCh/WHs3gUUQw2NEIq2RmUG/em3yILiNt4GuFtM1mBlX2OvF/OZvNyx8dwaeeVXyVFC5Q7+CIW3LpnfFXj9TJvslWRNZyUChhKmFlItGZnG+/3CeRaowf/4DwBlDQhunfiER7QbOWAZ0W7MDkNdPL34/LW2wkSIu054yccm7CZvOJm46S4hfaIhHR1k4F6+WV89s/zvL+vRuM/6TflXMJ9f0HsUVW4OS9+XvUPeef0sOtnGcooc5qjO9VYwcmKYoHXPQp2ZxboAyCorMiPAgo9garPijR0EEVAT1zyD3XCMjEVXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eNtge/rUQfDBrd4diNzkUp67zuonoVvTmBGwqG6cdQ=;
 b=MCwgFgnOjsnJNRFn/tSMZWN9oBTjoKidAJvSKIUOsMUzbqteiZ6udn7JVGbGsrUrUcRVi6eVbzXoCqOE1/3Foh//mj5SFVlL3JNtZEXGdPTNUpaaPRzPx59+fq1kXL44K3esyeWoY1Gw30VseiwNUqcEk3tQdlFmrbHHvayBHaA=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CO1PR10MB4692.namprd10.prod.outlook.com (2603:10b6:303:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 10:20:53 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 10:20:53 +0000
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
 <20240424224053.471771-3-cupertino.miranda@oracle.com>
 <CAEf4BzYuHv7QnSAFVX0JH2YQd8xAR5ZKzWxEY=8yongH9kepng@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
        Alexei
 Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust
 <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena
 Zannoni <elena.zannoni@oracle.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf/verifier: refactor checks for range
 computation
In-reply-to: <CAEf4BzYuHv7QnSAFVX0JH2YQd8xAR5ZKzWxEY=8yongH9kepng@mail.gmail.com>
Date: Fri, 26 Apr 2024 11:20:48 +0100
Message-ID: <87edasmnlr.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0207.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::27) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CO1PR10MB4692:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1209dd-7d45-4367-d17a-08dc65da8d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eUMxcTZGU0lkVCtUS2dqaFprOHhDUWVBdktlTzBFRUdtdnhLYXJDcHlpMWNa?=
 =?utf-8?B?R2hoVk9Ebyt2RlZvc3NUaXVYZTk1elZ0VjBGWVplQUttQ2NYclptRzhaQ2pw?=
 =?utf-8?B?UEFsaVg0YnVkM016SmE4NVF4eklFSDA2eUtVdG03akJNMDkyandlVit2ekZU?=
 =?utf-8?B?SHdlT3VEd25KbFNULzY2WmRkYW1Ma0lBdlV4cEZ0OUM3OVEvUzFDQWkwZXE0?=
 =?utf-8?B?ellmamxoMjExMlRYUGRIQkZjbnAvT3F2TUNIMm5QbXVtWFRPVUx3TVBmVFJw?=
 =?utf-8?B?eWRmdG5JYlBZSkExR0VVY2ZUV0FvSEw1VjlFRHhlSU40OWRMaXVMY2dBTHZB?=
 =?utf-8?B?RnhlUUpkSHM0cCtMREZ2bWZETU55VUcyblVqK0k4TEErcldGdjgzYWY5WXN1?=
 =?utf-8?B?eVZ0dXRvRVkrY0dPN0JUc25XeUtBRTlKNkUwOUppYVltbXIvWXFNNnR5OXA5?=
 =?utf-8?B?TVUrUG5jV1c3dnQ5VE5JcFRnUWx6RE4wM1ZrdWNFZ0NBeEdSWXpzMW5aYU1R?=
 =?utf-8?B?UjdDMEdpK0J0Z0p5SUZQVVpuOEZTRnphVUV5SXdHcUhyZHNwT2pzNXBLMVBQ?=
 =?utf-8?B?SWxOTDIwK0tXbWNva0xLQ0x2cEJZOWdCZUc5VVRwWE5FRUhSWXpMdDdlUnZN?=
 =?utf-8?B?bktMN2V1M1crOVd5YWI3Uk52Vm5SamVqeHp2alJnR2x6Y2VBWG5BVDBjQ1Nw?=
 =?utf-8?B?VDFxMC9yc2lTK1Q3RWpxYWZHYjlCekJpb3JJcUNDeE83OXNzbTV1U2xaOGF0?=
 =?utf-8?B?bE0vbko3TVhUSHdsL25IajE1cmVKUUVTcGNoSHlERkV3aVJrY01VSFdIdUs5?=
 =?utf-8?B?dytJWVFHMEhtTENCdHVGZDJFTVZ2TEZkVjByaWlWYjlBVWdlRnlHNGt6VGZw?=
 =?utf-8?B?a2NVVmxBaWlKdzRZc2lJK1A2L2tPbEU1eVhDZ0JXN2tvd0lqVUJKOHN2c1NJ?=
 =?utf-8?B?VXNzMWJzNWt5dWNVY2VjUERpZ0owN0diT0phYkJDTkpuZUt4UGN4eDc1MnlV?=
 =?utf-8?B?cjdTVis5cHQ3ZUY4eHN1WU45MFZna1d4RzdnL0NIT2RKa2U1UEhETHczSW9R?=
 =?utf-8?B?K21PUE9DbXZaVGlMOXhsaXBmdk9BZWsvQmxwRkVCZjk4TTRWeTNyWkVHRDdi?=
 =?utf-8?B?c1Y3eHg1cVhlZlIyYnRGZmQ3VXNSMXFVUXhVaW5ZcmJnNlZTSFp4a29FVmQ2?=
 =?utf-8?B?YlBKdnorcXhCazAyQjFqbWFVbU1zSEJkV0FZWmlPb2k0NXZORGlQaTZIZWwv?=
 =?utf-8?B?QmVBbkVxWHpwZDlGL29TcVBPc2tDMVZIVHRQVXZVWUhwMFErdmdwbGR2M3JI?=
 =?utf-8?B?akVWeFFVU3k4eGthMGN4L0w3MHlmVkVGRm1qT1RwL3pJaWJtekp1ei9XVEJa?=
 =?utf-8?B?QWhRZDZZbW5wYVA5SDg2bk5PcjEybWZrMWV1MnQrTjBPRXV5ZDliWnQySzZB?=
 =?utf-8?B?by9YTmpTb0pEd2sxUzkxQnVKeTlkd20xSXJvWERlckFaTk9jSmZPSmozdUpz?=
 =?utf-8?B?ZlNlZ0NqZEd4OWN0SllwcXoreXRWS0xCTXgrTWFvVVFxUFNsbkRkVmh3MzJr?=
 =?utf-8?B?RGxIaTV6WGpGc3hhN1FsTjYwWE85MVFSN2hBbDFjWU5ielpYVW9mMTh0L3c2?=
 =?utf-8?B?WTZtcnhSRzJoWUpsdDVncW9mbU4rZ1JZdGc1WGV4bGNGdzZzcm5ldjhWeHM4?=
 =?utf-8?B?SExrRzlOUXhGbEUvbUdzOHg1K3hwTHU4U2FlL0NDSnR0TnlSOFEzcXBnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U05OaHlIUUlUN1YxczU4ajdPT1lKdHdtZHpQMWhodnFHdTZNckdhYzdqL2sv?=
 =?utf-8?B?NlRWUVpvSFFkMzVmRmpJdVRaVlZSVVFIODBXODhKZnNadlVhTTBBUDFPYmtN?=
 =?utf-8?B?N1BHMFloYmJHV1RyTTE4ZnowNFFsMEpBZmJvbU00eDdqQk15UXc5dmF5azNk?=
 =?utf-8?B?S05yZTlGS1lrRWpUNE1PcXZId3NraXhuaFVJMGhid3dzbFBzaWpwZmQrS3ZM?=
 =?utf-8?B?ZzgzUXlRT0FqL0FDS1IvZk93WUxmTzl6cEdQNm5hdGl4VjdZOFMreDNzbUxU?=
 =?utf-8?B?TG81WlFOSW5DYmtmWHNQOXo4clNDeWZuVE1VcUVMTDdKRjhPL21XUjBXRlZu?=
 =?utf-8?B?bkJrQU8wWlhDb0k4UGJiMEFuZkZKc0lCMVhsTnBnc0ZVU2Y2NnAyLzY4dHM4?=
 =?utf-8?B?em9NVTk0VStzSnBxOHdKUnVKWFdyRU9VVG5FMXR6NmZHVHFqcHArZmluMVZE?=
 =?utf-8?B?MzhvL3ZZaXVnSllDVmVwaEJXY1R2TkF0NkV6VHZEMmErWXBRem1neXJzeFdF?=
 =?utf-8?B?dSs1UllRd1BBUUV0TjNuV0J6bGlxWkoxZy9wZUx1RDVvN3VpZlJGZ2N4QVJm?=
 =?utf-8?B?TGRnTExUNytSMzBmT3JPZDZWWHo2bjJHeTg1dE9QTStVSTJWNzJHeXhmTG10?=
 =?utf-8?B?K0UrdU1JelVtOXhBcWpDL0traThpSC96azl4ZFhjZnZCQ2NVcE9DSzkvS2FG?=
 =?utf-8?B?UlVQL2hBazR0M0wzRlg1NWNQNzVZNlViWHJtclV6S3NWeXN2QWRFZ2FpVWhq?=
 =?utf-8?B?TitSc3JIVjJiWlZ1dlZsbTZpOEd1TW1udDMyMFlyNExEaVk2eDd2MEIwb0Rk?=
 =?utf-8?B?WjRQN3d1emVBTjh1RU5OakR6YXpaZzRuODBLdmxIVGJvZERBZGVpLy9YTGZt?=
 =?utf-8?B?ZmwrTEdSampobkZOSXM4UjlldlJ1Qi9PVHRIT2svQ25qZlBSMEF0ZUxyMFV4?=
 =?utf-8?B?SjRzWXBMaWxrb3BPWklsZHJ4RnJlbk5TWFZVN0VudzR3ZWRsemU4a09hV056?=
 =?utf-8?B?MGR0aXJZZXlqa0FTbExkbjVQOU0xRjd5VlFwWkVlcG5XajR5d25wWENtU0RG?=
 =?utf-8?B?dUxpUDVhR1cydld4VzV6MFBoTGtZTUhBRjRCdEdFaERGcnBtb1o5U3h0Zk1E?=
 =?utf-8?B?c2FXVklmeTdvRUxja0VZNTY0b3J2ZkpUV3V5ZC9obmd6U2hyZ2dQMVZ0aG0v?=
 =?utf-8?B?dk5ZTEQ1ckpsU3FXMFhYUkFDVXYrQ3VucXlTOVlRUmgwRFM1RnNVUTdGQTFL?=
 =?utf-8?B?WEFQYnkrWUpiMGRyRDgxQ1lCSjUxbTVoTFVLT0Urd1lqc2VCdHorZWNqNW1l?=
 =?utf-8?B?d3VDSndNKzRKbmdJWEJGMWZqVnZ5clYxSEZPQXFhWTRYdEpPaXkxS2h2ZXhG?=
 =?utf-8?B?MklYdkw0cFJZdm5BeHpCemloU2tvdkJRSUJ1eThDbENGV0JRdDhaS2NUNkJk?=
 =?utf-8?B?VzdSRmorOC9Vem51STFoeUFxaE9DbmJjMnJiQnAxbXl2R2tQdDViT3dIR0tE?=
 =?utf-8?B?alg3dWgweWRxM05mWVJHemJ6OTNnbE4yMWlVeWNDSmhUVlpZRmNPc2t2UEhB?=
 =?utf-8?B?N3VXamhUb05rMzVKd3QrMkdGc2JiaEh6ZFUyeGxwcWU3eC9Td05FOWtmY0RE?=
 =?utf-8?B?ekp1NmNySFg3bHAxNi94ZXgwdFI3akRYcW5JZ21Cd1A1dXVTWktqT1ZxdGxa?=
 =?utf-8?B?cU4rTEZjMDhxYnZBYzl5REZLUExjQnNRUFV5bkdSS3M5MEo1cTBCRzcxTnpC?=
 =?utf-8?B?Um1FdWg4ZFB5UXNWeGlUeEE2TGdhNEpLTVZMZ0tRRUxnNEVQVzhXY2FJWkh4?=
 =?utf-8?B?bW9aZ1M2Y01vQnBhc2Ivd1FPRUltTElVcGkxRkxwaXRtajA1VG5hbFk4MU5m?=
 =?utf-8?B?OWVDTWVTT2VhWWVCdUNQRE5ocmFlSXV5TExNUGthWktGZGdWWkQ0SmVzYkw4?=
 =?utf-8?B?cWJydWVXdTVadTBLUGFvaU82VWlWRkVwQ1VLVldaeHh1clk4TVdmNUlhVzRm?=
 =?utf-8?B?WFB5d1dCQW1OcHoyVndMa3BuQ2R4dlZGQWVlOFFZSW9ZQytWRnpIN3F5NzNC?=
 =?utf-8?B?MDBCVkNRcVd4UkJaNUVYcWRDcHQ4YW93MjMxOHpwdjFmaVV4cUpmYklzUW5W?=
 =?utf-8?B?Y25SdUVNWGp1T3dud3FsVnZYQkJKTm9nZG1oUmx1cW1uWlZqbjc2TCtJd2hv?=
 =?utf-8?Q?QclJY5bcmtK//qgZMdd5o+s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YMjdMgOlmvkVpIJF4bpttLqisTsH8Su2uotrpcboV50NhJn33s/Z8HC5Qx54CZa0Rim7lFyTAbQ9d5Ub0QKY/y3xWVY2ymfI6ba3FnS0pAUTY42YZlupHv1gFXgPBJBnjlTcrvdWamocf6WlK2Hu2p/XbUe3yqvIFbIiatTTnAmKLiiA0zFHFN1hwSTy1hiJ6TRQwBoJ882Or6nRwziwhStzOoN1d9JwX0IVYCsZcq69RvujYSeviypByJudVCXX6h6IvFHxSxEBAYMJjctCwh5cpUgcY85WDsnLM2Sq806N02KK2HEpq8a+byAxoaB7c52R3QlhD8XSezibA3zp6quaV66rJhkk7cOIg+eNRYogA+EgXWcoyFYEUizLycpIoC8muXHCgY3lg9bT1Sb22YXVwVCI/2hivndGdUnUQJMErP1XwJoe01ZAJxKwwSJUKzp/2mL0lyLWpsagXAIKpB4j1FM/ymKRmH28quxv1x/weC6+Ph8uZS1iEosQolEHH5TGwsMuxLcpjdauo99SCPhoWupo877kMrDnhtNUqJPyc1mSWWBvBph2RaKNteKXSDNbxJJMiV/cAOecmky7pxC49biiuVPgh5A2Zf6/vtI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1209dd-7d45-4367-d17a-08dc65da8d6b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 10:20:53.1922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctNxwVKrSDwZ4ma6fAUxd80zPiFg+Q0tk5A1HvhAQjKLBr590FZZF8TmJnd1C38NBaTHXokEV/GRw+pXeJGXdeGOvhqpQ/o+bVJbv9Zdhm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_09,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260067
X-Proofpoint-ORIG-GUID: lweAq0cHzXswVWAQdl3KvnXWKQcgDxAo
X-Proofpoint-GUID: lweAq0cHzXswVWAQdl3KvnXWKQcgDxAo


Andrii Nakryiko writes:

> On Wed, Apr 24, 2024 at 3:41=E2=80=AFPM Cupertino Miranda
> <cupertino.miranda@oracle.com> wrote:
>>
>> Split range computation checks in its own function, isolating pessimitic
>> range set for dst_reg and failing return to a single point.
>>
>> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
>> Cc: Yonghong Song <yonghong.song@linux.dev>
>> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Cc: David Faust <david.faust@oracle.com>
>> Cc: Jose Marchesi <jose.marchesi@oracle.com>
>> Cc: Elena Zannoni <elena.zannoni@oracle.com>
>> ---
>>  kernel/bpf/verifier.c | 141 +++++++++++++++++++++++-------------------
>>  1 file changed, 77 insertions(+), 64 deletions(-)
>>
>
> I know you are moving around pre-existing code, so a bunch of nits
> below are to pre-existing code, but let's use this as an opportunity
> to clean it up a bit.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6fe641c8ae33..829a12d263a5 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -13695,6 +13695,82 @@ static void scalar_min_max_arsh(struct bpf_reg_=
state *dst_reg,
>>         __update_reg_bounds(dst_reg);
>>  }
>>
>> +static bool is_const_reg_and_valid(struct bpf_reg_state reg, bool alu32=
,
>
> hm.. why passing reg_state by value? Use pointer?
>
Someone mentioned this in a review already and I forgot to change it.
Apologies if I did not reply on this.

The reason why I pass by value, is more of an approach to programming.
I do it as guarantee to the caller that there is no mutation of
the value.
If it is better or worst from a performance point of view it is
arguable, since although it might appear to copy the value it also provides
more information to the compiler of the intent of the callee function,
allowing it to optimize further.
I personally would leave the copy by value, but I understand if you want
to keep having the same code style.


>> +                                  bool *valid)
>> +{
>> +       s64 smin_val =3D reg.smin_value;
>> +       s64 smax_val =3D reg.smax_value;
>> +       u64 umin_val =3D reg.umin_value;
>> +       u64 umax_val =3D reg.umax_value;
>> +
>
> don't add empty line between variable declarations, all variables
> should be in a single continuous block
>
>> +       s32 s32_min_val =3D reg.s32_min_value;
>> +       s32 s32_max_val =3D reg.s32_max_value;
>> +       u32 u32_min_val =3D reg.u32_min_value;
>> +       u32 u32_max_val =3D reg.u32_max_value;
>> +
>
> but see below, I'm not sure we even need these local variables, they
> don't save all that much typing
>
>> +       bool known =3D alu32 ? tnum_subreg_is_const(reg.var_off) :
>> +                            tnum_is_const(reg.var_off);
>
> "known" is a misnomer, imo. It's `is_const`.
>
>> +
>> +       if (alu32) {
>> +               if ((known &&
>> +                    (s32_min_val !=3D s32_max_val || u32_min_val !=3D u=
32_max_val)) ||
>> +                     s32_min_val > s32_max_val || u32_min_val > u32_max=
_val)
>> +                       *valid =3D false;
>> +       } else {
>> +               if ((known &&
>> +                    (smin_val !=3D smax_val || umin_val !=3D umax_val))=
 ||
>> +                   smin_val > smax_val || umin_val > umax_val)
>> +                       *valid =3D false;
>> +       }
>> +
>> +       return known;
>
>
> The above is really hard to follow, especially how known && !known
> cases are being handled is very easy to misinterpret. How about we
> rewrite the equivalent logic in a few steps:
>
> if (alu32) {
>     if (tnum_subreg_is_const(reg.var_off)) {
>         return reg->s32_min_value =3D=3D reg->s32_max_value &&
>                reg->u32_min_value =3D=3D reg->u32_max_value;
>     } else {
>         return reg->s32_min_value <=3D reg->s32_max_value &&
>                reg->u32_min_value <=3D reg->u32_max_value;
>     }
> } else {
>    /* same as above for 64-bit bounds */
> }
>
> And you don't even need any local variables, while all the important
> conditions are a bit more easy to follow? Or is it just me?
>

With current state of the code, indeed, it seems you don't need the extra
valid argument to pass the extra information.
Considering that the KNOWN value is now only used in the shift
operators, it seems now safe to merge both valid and the return value
from the function, since the logic will result in the same behaviour.

>> +}
>> +
>> +static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
>> +                                            struct bpf_reg_state src_re=
g)
>> +{
>> +       bool src_known;
>> +       u64 insn_bitness =3D (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) ? =
64 : 32;
>
> whole u64 for this seems like an overkill, I'd just stick to `int`
>
>> +       bool alu32 =3D (BPF_CLASS(insn->code) !=3D BPF_ALU64);
>
> insn_bitness =3D=3D 32 ?
>
>> +       u8 opcode =3D BPF_OP(insn->code);
>> +
>
> nit: don't split variables block with empty line
>
>> +       bool valid_known =3D true;
>
> need an empty line between variable declarations and the rest
>
>> +       src_known =3D is_const_reg_and_valid(src_reg, alu32, &valid_know=
n);
>> +
>> +       /* Taint dst register if offset had invalid bounds
>> +        * derived from e.g. dead branches.
>> +        */
>> +       if (valid_known =3D=3D false)
>
> nit: !valid_known
>
>> +               return false;
>
> given this logic/handling, why not just return false from
> is_const_reg_and_valid() if it's a constant, but it's not
> valid/consistent? It's simpler and fits the logic and function's name,
> no? See my suggestion above
>
>> +
>> +       switch (opcode) {
>
> inline opcode variable here, you use it just once
>
>> +       case BPF_ADD:
>> +       case BPF_SUB:
>> +       case BPF_AND:
>> +               return true;
>> +
>> +       /* Compute range for the following only if the src_reg is known.
>> +        */
>> +       case BPF_XOR:
>> +       case BPF_OR:
>> +       case BPF_MUL:
>> +               return src_known;
>> +
>> +       /* Shift operators range is only computable if shift dimension o=
perand
>> +        * is known. Also, shifts greater than 31 or 63 are undefined. T=
his
>> +        * includes shifts by a negative number.
>> +        */
>> +       case BPF_LSH:
>> +       case BPF_RSH:
>> +       case BPF_ARSH:
>
> preserve original comment?
>
>> -                       /* Shifts greater than 31 or 63 are undefined.
>> -                        * This includes shifts by a negative number.
>> -                        */
>
>> +               return (src_known && src_reg.umax_value < insn_bitness);
>
> nit: unnecessary ()
>
>> +       default:
>> +               break;
>
> return false here, and drop return below
>
>> +       }
>> +
>> +       return false;
>> +}
>> +
>>  /* WARNING: This function does calculations on 64-bit values, but the a=
ctual
>>   * execution may occur on 32-bit values. Therefore, things like bitshif=
ts
>>   * need extra checks in the 32-bit case.
>
> [...]

Apart from the obvious coding style problems I will address those optimizat=
ions
in an independent patch in the end, if you agree with. I would prefer to
separate the improvements to avoid to change semantics in the
refactoring patch, as previously requested by Yonghong.

