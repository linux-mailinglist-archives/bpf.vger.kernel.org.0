Return-Path: <bpf+bounces-21512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BED84E57C
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 17:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DDA1C24048
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF4E7EF08;
	Thu,  8 Feb 2024 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fd1SdPEN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EbfPUf3H"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2F67F474
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411128; cv=fail; b=LVVgV0Dpd3csaqnKavpObfrwO39+ZVwRSlJxTrAN3CkREEo+zGArykfMDaQfaIvQw3Mc4Ty52qvkAWgbufhYxYaXMWLsaj+PqG2IvJilPzrGuosZ3rtTwLqdj+zbTeg4FdInMAHCz1G7imeiHD1Ot/TN19anGcmWPaCLmAn9Tes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411128; c=relaxed/simple;
	bh=VfYONkcCtv7l4zO5zCY4ylEYKLBMg+VFAmm7brY9v3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=H07GfeEwEJ/F4+R553FUw4DZTEwzouQ9tzCFxrX7hanFW/6ypHFV7CdRL31FZyONH8O+UjjOqvmDV0UeXJawDEJyYzlmCfQShftT9hktFKGRZtEFlj6vYwYmg0+4iPrnP+CzXpKzRBy0OlI57tEqBXjGlGxDXHUylekRuGWbto8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fd1SdPEN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EbfPUf3H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418EKVRc000991;
	Thu, 8 Feb 2024 16:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=wL9X7SOn+rjUt929Y2uKAeLj3WGNvP9q1I/jxDfD7bA=;
 b=Fd1SdPENaWCBFtoQHw793ssWbpKL6/cDS2VmqkPleLY4r++BHBeR0n/5H97T0+k4NJrp
 tsVCRETaOkNe0ey19IsEkbkWfvg6B/baJP8SJ+mNIAIHfh8VZ0ziGh1IfdEYH4cXltOv
 JUe+mpxbiCzp1UpwpYhumTBVj4QkfXho0sNQrAATflKgW+2WM/TPhIz5JQg2gGiRZHI6
 7SJum9PCQmtyL+ZMq3CHdiRHQAH5wR8Fvo41HzhpMJEEpvvhzxoYJ82KJIr4ETVCncr+
 XfM+8GtEElBPYTSShaVG1EGO0/wBYO76LLzlWSCOrZsiwd41UN+YxjCDdeGblcHPhD5z SQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdd5ahy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 16:51:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418GF9TQ036711;
	Thu, 8 Feb 2024 16:51:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxaxrkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 16:51:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMD+++lMZGNQFUgDd0fWTdcmTIdEdjL/+LyGEj3CfZQ49O+q/UCttHLkX2e1bFOinVM7r+NsSDGLdwzSlylxJVUHvw6qu3smei7mcjnXA5EPRDc8dWNOYvd6at9USMbGOp6kn2Z0swysPNceU4Fcutn+Dd7OX/PA21e9G633G1wIcizSgctct8Gc40qkvSknXhCiRv35uXC7ogDnj5gv7UvDfDT3KotyGr6RZyQgO6HQI332qPrhPzmqbwgzqO580liPM1HP9QFfFvfrbelh6XcvPfL4dcGNnSxOPfjDnbARTt3AKO6uZR5n99vlB6iBeCwnGdPPI6+Bgymb9vXt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL9X7SOn+rjUt929Y2uKAeLj3WGNvP9q1I/jxDfD7bA=;
 b=YFpQevjd8NN0WrxyUTHUT+88/ujh9cxRteX4by7pGL4Y/vlDaYMuWznLlitieARe0vqETr2ahigCq2P/A0N28ubUnU03LYvWOIE9sM618IU2hgRsT568CZFcuV67PFu7Oky1QeeGSqp5xxG+UxcbZTAu0v36hs26yzJnPTQFNzzpj/fczae3SciGwKFKkkea0myqYGNNHZrT1vPec+Ksrr6vph4xKAiaAyCNjvWUaqiSVoxLvJa9fDLQMJYaph4ixpwwu7rABlsph4EBYE3dKZBLfXrNfdm7g60+WFgLdQDaeW5MtNUmh/F1Or2RZJxlpKS5ZxY21P1VgdiglNjSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL9X7SOn+rjUt929Y2uKAeLj3WGNvP9q1I/jxDfD7bA=;
 b=EbfPUf3HxaEU2aWFZl8Y0ZJkcZ6YHHNRE2yTE1SGA/8DiKEKVTCTUkCcjNT7FT1Py04r+4VJxShrM5O0TDU4hQ7ILQxK2qgjdSu2+r2nUxIDHpmxuYtd4roF2mVf+5v6KFBuSibsUHz70LtzXR4wbMN/bq4lqTv//HNXXW+HRHo=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Thu, 8 Feb
 2024 16:51:54 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 16:51:54 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
        Yonghong
 Song <yhs@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
In-Reply-To: <7d2b05bf2e7ae7c95807ac4b2a9664f203facbfe.camel@gmail.com>
	(Eduard Zingerman's message of "Thu, 08 Feb 2024 17:53:48 +0200")
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
	<c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev>
	<87h6ijfayj.fsf@oracle.com> <87wmrfdsk7.fsf@oracle.com>
	<4ad9dad64b38ae90e4a050ce5181ced750913b23.camel@gmail.com>
	<87o7crdmjn.fsf@oracle.com>
	<eea74ef852fc57e9fb69d18e1e5960523c4f7abb.camel@gmail.com>
	<87il2zdl43.fsf@oracle.com>
	<7d2b05bf2e7ae7c95807ac4b2a9664f203facbfe.camel@gmail.com>
Date: Thu, 08 Feb 2024 17:51:49 +0100
Message-ID: <871q9mew62.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::8) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 16375156-3b1c-44c0-31fa-08dc28c640ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	u1Yd+vkji3KJaL/Uo9QaB4FVQb3roVFJqHo6ejnB7KOzmmesWzeiOSHKffpscei5LoNVtZfQK1rjiwKLZSGoUBbTwpKi+IvyL8v+YzpDbRN7nkYzeU/IUSCxh4m0l3a+z2c1/yRKVS4w8iJ0uMLgJ86QZXdm/hDE19cWuKsu4Li68foGKNExV3uRlv2Xxr5kZuTjttlToWRjV4T8c3rl+QyGF4g1IGGmLSRnayeThMB5Zeavd/Nwk5FAX7pB/8j2LKYncPiXgO3OxYrcEy6qbXrrkFRjt+0RcNoK4nxOAyxpsDy2odAkUZNkpKHjefdEsSrGLq2RHENdVzbgCH1H6+K5zhkliLpZCggLB0wRdEPgO25mRD3n88dKOv2Tt9+FChM3ZuewY/JwbSZ8pgxSaZjzmUPDsN+JV6id1S/L3CsBLn9HvCFz0tJIlgX4iCrczTkkWa2wDrRvSC+QvXd2kp+0ukQatpDi46S/JiZ0Z9dIRl8Sin3n7WiBpM0T/ANImYa1Qlb1FXWNBHnVDQbrMzQDWGWw2GoZgjaPFT1VNoI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(8936002)(478600001)(66556008)(54906003)(6916009)(316002)(66946007)(66476007)(6512007)(8676002)(4326008)(6506007)(38100700002)(6486002)(2616005)(36756003)(107886003)(6666004)(86362001)(2906002)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RKq/of7F6VZDgGoACHdxz4UX3Z9fvo08nwAlf5uV+Zv8ZJX2LmE6L+yX1ap0?=
 =?us-ascii?Q?zQffWJBZdYD5Pd0imnKagpIIiWXvwmY51q4pqNKqZauZi3II92RGX9OrbOlf?=
 =?us-ascii?Q?8ycnngAKemf75mLMAL9jPbED8TQimwIkLmc5v2C3xsGsU7llqBn43RXUKf4t?=
 =?us-ascii?Q?qqxLzrChqTSBrROfTb2GEXtEPvchZ+8RtlBwvNUJzmrHarwAo81eADDp5Iip?=
 =?us-ascii?Q?h8oO9D2fh50papidwnmOpJnuIFNUrVa6NDnSrZMKaMJTPuBIfLuFw+G6GolE?=
 =?us-ascii?Q?p/tLKVBrk0m7T09jpj69xwB+JG4QQp8tXUpAdIlCrPwiEOP+f/ymVTjQEVLz?=
 =?us-ascii?Q?oMB2Iyvc9/bccna5F3RKrK5hKRJ36QQK5B5tbeEDENAtrLvOEDHCK6Rl3b0T?=
 =?us-ascii?Q?oYGh0jdGabLLXCSz/b0Mve07Dctj+gMyVFWF0G+AGY3bDEErIDcGn6C2J9Jc?=
 =?us-ascii?Q?h0K1HCOolQCW0C3Lqfjshn8bYoaIWJWeOYfQwGCm9UXoOx6RXSZxRLbx47P6?=
 =?us-ascii?Q?nwbmglXFwCmrCQfGWwBfyhJcEZ2Ggms+Ohe/2htnJFgDuRjAeFrrgt7Cwqpa?=
 =?us-ascii?Q?ZPNWXEAdBSpVoOTuRquOqCIrTtJLby/EURwUiDqnX16FJdC3dKCPUrff9ve5?=
 =?us-ascii?Q?hoZfBLGBCVSocg5kneyUE9TFGqgpU4WWF3ZnkT/o45ayWs8OBhZHD2lKjG3c?=
 =?us-ascii?Q?ZNm5bAWD3zwsbwZqHhyFiZu26blNHLjEi1o2amJjyNNci79+BiwAg1B2xJQq?=
 =?us-ascii?Q?3VAEWK/jJnMHFLTmmZvgy7Pfc97fqjprR/Im+qb/TvXFAU/7MYoCyJMIh8Kb?=
 =?us-ascii?Q?XUvX9ZvC0Hl/tgrh11Jx+q2YnkFunSl+uVVMfhVvfp1VRPhLZpcZaz+gka2y?=
 =?us-ascii?Q?nSeqQS6sbcPDkZuY66iz7oWe++Wnw5nsAY7dQfQV3l86VfEJH4RWuapQGe/i?=
 =?us-ascii?Q?bZVI7dtjx1JBloZ3EITVPcfPrjQXpRpaw96p++KfC/EqO9PoIs9mrmL0J2jL?=
 =?us-ascii?Q?L6iY0ZXO5EJVugSjVcNJbBm+ya8oHw0Y34rtj+dPKYfa/aV23hJNsj2WLhtp?=
 =?us-ascii?Q?wHJsFxt8RLp0rXEheI/cFq8pMpIZQBnsdkFw30P1uob2wqatboiE1QQvBDtt?=
 =?us-ascii?Q?wy3lTWCU06gb+FygfyPEY73OC7OZ+6F/jf1lpYAw6tWAoMQMdzOFzbRtErK7?=
 =?us-ascii?Q?GdUMKcgcQOHvgpgz7lkNEJL5Sr8H2hTrzLHQaCDt5Cd9ovHf72aBo4RtBJtV?=
 =?us-ascii?Q?PU8pDMlbTRO4ikmp3iwwXrOWegu68nkvtJpTY42xrlfKk8Y3xvVj7Q6U9ZH4?=
 =?us-ascii?Q?zzKaJGKVTbKBZBdBfCaNi60smHOkyoYYsvwVi33EyEnnccp2Uwrgw5GqZkEM?=
 =?us-ascii?Q?e5PxyO/ZRsQmG3okGRWfFVLc/jde5a99yoDuEj9GDteQDpoBmswc/LdnlaNj?=
 =?us-ascii?Q?DcZhh9Fq9OY84kAUeh0uXhexOuAF21VVxxATPGNZ0vwZ0isV5tOoXeFZb/iK?=
 =?us-ascii?Q?9vhCp4x6dxmF0ciyyfZo3GMAi1b3VAPCA43za3sWomrxHvVZpSAhwlWzCQIE?=
 =?us-ascii?Q?LvQMI3c7DSN50jsUigawzHR41C5yLPDrLIUuB5kqbEhh9C3XSRZ9Unh6wFZl?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	McfoTzdSDQ/8vbaQ+Iy28gCPm4IqM6wzdu/HvlSK7rfvEiZf1prvvYN5YZjBcY22AmZCkpcYJExbNsPkfFw/jvuhnugpNErH2JYvh99LcfIWHpDy7g+yTbivXZgK3H/Tzh1vBYAwynOmKH5X0qlWN8yyLDs8dmeAmyduEnkFQhgxfVUPvCqCOyjB59pryANCNMkyyQ8h+uPdpLLS2Eqipmv01e+HhdZnqoW8xbPw7qh7/wNOr2vRDC6scy1Zrmp30yWeYo3fgnppKy0SV4+YQwvokRK/vbvsJEUJkLW8bBZ23yv9dv4f/dACsgq2uuHo4ep2xHG2JLxiv/o9Ck79bZ4MFr+CoyYB093sexTmKa3UQxSpJaYw2BhGfZTi/GicDHaFzonTo07+GtKXx0VczSwy3F56/GiWEVqb6WV4+pbBj6pyOIABAiYPkJ7ztkCj+NHuuFfe6WfruuU4Aa+47mIT/Wf4SVZmyu+7DqUiGLSCi02R0T9M2XEW8Its76VhHNEOMkE0uGo0XqQSJjZocJ0l3Ezz/7YJDo7UDi/OSBRi5NgtVTUNQTH6qw9TjdXtb9QpvT/tZEM9suxONf4XgjL87shqn0jUGKY1NGzS4Mg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16375156-3b1c-44c0-31fa-08dc28c640ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 16:51:54.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gs3/snXf16QO2iJeyb0l4rTiLh59W3J8z9wEwuYceen7xdDREotkBSqnjWyqeeD6ozQ9dT0y0fxUqZaKfn669AR3pU3Xt+/Md2LXN8BiOg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=726 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080089
X-Proofpoint-GUID: GXSpQ2Osgtzx-DLA-DXUJw05R869iEfn
X-Proofpoint-ORIG-GUID: GXSpQ2Osgtzx-DLA-DXUJw05R869iEfn


> On Thu, 2024-02-08 at 16:35 +0100, Jose E. Marchesi wrote:
> [...]
>
>> If the compiler generates assembly code the same code for profile2.c for
>> before and after, that means that the loop does _not_ get unrolled when
>> profiler.inc.h is built with -O2 but without #pragma unroll.
>> 
>> But what if #pragma unroll is used?  If it unrolls then, that would mean
>> that the pragma does something more than -funroll-loops/-O2.
>> 
>> Sorry if I am not making sense.  Stuff like this confuses me to no end
>> ;)
>
> Sorry, I messed up while switching branches :(
> Here are the correct stats:
>
> | File            | insn # | insn # |
> |                 | before |  after |
> |-----------------+--------+--------|
> | profiler1.bpf.o |  16716 |   4813 |

This means:

- With both `#pragma unroll' and -O2 we get 16716 instructions.
- Without `#pragma unroll' and with -O2 we get 4813 instructions.

Weird.

> | profiler2.bpf.o |   2088 |   2050 |

- Without `#pragma unroll' and with -O2 we get 2088 instructions.
- With `#pragma loop unroll(disable)' and with -O2 we get 2050
  instructions.

Also surprising.

> | profiler3.bpf.o |   4465 |   1690 |

