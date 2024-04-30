Return-Path: <bpf+bounces-28228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E7A8B6B4D
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 09:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A2B1C21D56
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 07:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18362374E3;
	Tue, 30 Apr 2024 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DJ2sZPIf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="irP68+iU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFBD36AEF
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461477; cv=fail; b=RYfOIn7ujvr8+jI+pPVARKN+qglRXAAjpY2HqYnE9vvRxlWsj/TZTEH1CnLSuk1a1IhmONwQC6hcOi9LUFGwicMALSVyCbQ2JXDbkWK0u2T2OYfXEGSrmB8FHJBbycJA1zwS42AR1nADndKeuzFhNClbZwM4qs0zhvMXJHw12fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461477; c=relaxed/simple;
	bh=UyO/9clvxUQmaTCHxCbBK9ZxpmxGw1hWMKecs29xOzE=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=srAviub252gZp/r2bsdyJQzabzk0MoEuU9iRxBIxgkWG6JV91OMG+Nv5NWSydsW3bOmcMdFT56jD83J6sF4oTdHLednlNgfz75O+abjdJCLRsI834ckWUagTat/6l0UaDl2VexbNEkPwqH1waeN+tBXpzorME3Vj9/KUTpbFhoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DJ2sZPIf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=irP68+iU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43U1hpZW006302;
	Tue, 30 Apr 2024 07:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=nQmRISOYqLY2E9vFFR7RydKIBtg8dBYv0vHMUo/nT1M=;
 b=DJ2sZPIfHTQZhfN7sgxZojDx651VkSkQZDka5OBBFxwjRizomT1yXN4MZYhEZSqgU6Ff
 b9R9iuASYESarNtnvMSdrhjuQtcHfoktLSw8GrhdU1ErcID6A4hJCTZyfRzGRrGh26cp
 PxYmpVzaNf0XLFfnKnUfr3FKjhtPCVAxGz1qWvvGkBEPSRfIE1i1lfqOibKs8qhw1ZXM
 ff1Ec5Vr1yyqhq35AVKBdeRg8ko7l6ZdQe7w6EupD3hLwbXxvpFDckB/54ppwpoC9niS
 Svx5fJ1g3JYi8dlUdlvby/rwVdptgTRK0FzPdGKLqAE7zCbxxzfuAJvICqm8J7n8NosI wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54cb0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 07:17:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43U5gkTt033156;
	Tue, 30 Apr 2024 07:17:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt78he6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 07:17:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUXicKL/CHv/TTfTDEGPNfN/gitSsxlCYgNoJVi2ir+uhZIzlZL6tgUynlGj6fBfLj+kbqjhLSIgTGUveMj62Mn9gJocUyz+VnmFL3Jl3X7asnaB6HtKqf6aXFgJbsYIgYixAEck8ivdy8EJX1Jv6G5RDKssL5Kci+ab3YCN7/0ZXnhJ5AL/PCBxU+ng+f/ttKmzjPdUssQfv7o8UrxgjDKZjuVpWM460V+Gc00a8bZpxT01qJUYE+qTZdiIvyR6LsoNzcEKQMle++9+693H2g41JCye3v4E0wn8XKxnxovhnFVa8MbGmAJGhjTOGoUtYUhRhalSVifSK2LPkP3OvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQmRISOYqLY2E9vFFR7RydKIBtg8dBYv0vHMUo/nT1M=;
 b=YHqs7tD9DysHB+RztFZcNmtqv/wkl7nrxCLuj4NyMd8HPSdsqgx8YtmOE21vDruIOo4b2KDzGTfNn1xOO/tcBFqDDMnxObEDuCagO8TdBIDS5CavzLdGLB9kmFTDt6mWXHwsxg5BeWgCfKa8g7vwTph/HcQmDRHiOPJDs0bom8TirhB0VKZM/nwin6IyQwrYpdmAk0tmxxT4SQEX+Z7aXTVURcrs7RwNXFqyvsbgQoXDoZNSzIxy3KGEPf55hpHsZV1JJ7rMbwPE3MYnPG7MzvHJnvOXwmRr8qM138pHNvOiuvwYxlTJmRt2k/6KCBDdAfEshNCB4THzvUhafI+hgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQmRISOYqLY2E9vFFR7RydKIBtg8dBYv0vHMUo/nT1M=;
 b=irP68+iUFPaRYoUXm1SjwaFjzKdu2uVMCK8xZ8C/RMJUBKbaP/Tr62Ih90hu8Xho9YIQzagL8Tu3nYCni6qwEXjjgcLKz9PnP5/jeSUoF5JUQMtbvhnZ+mWZ9IU3BKCbHDFcIgQG55VTLilEbhLBp0ZgCjJzgnjOwLcht4uLZog=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 07:17:47 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 07:17:47 +0000
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
 <20240429212250.78420-3-cupertino.miranda@oracle.com>
 <65e3b41c78870a563136109e26ab84cd880154c5.camel@gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
        Alexei
 Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust
 <david.faust@oracle.com>,
        "Jose
 Marchesi" <jose.marchesi@oracle.com>,
        Elena Zannoni
 <elena.zannoni@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/7] bpf/verifier: refactor checks for range
 computation
In-reply-to: <65e3b41c78870a563136109e26ab84cd880154c5.camel@gmail.com>
Date: Tue, 30 Apr 2024 08:17:42 +0100
Message-ID: <87y18vl3op.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0029.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::17)
 To MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|BLAPR10MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 4798d54e-fe60-4850-5813-08dc68e5a323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vUMAZgS3JdYpcC8CGiQSLPw/A0rghMAkqPO1VF0pcUZO3n1qVaNk0o/TF5xA?=
 =?us-ascii?Q?RpkdUFRjPzqPmTTwO4kNQ0JiDlf5APYOzYI4KPU1i4esObDybuJS2IULcr9p?=
 =?us-ascii?Q?+AkWVxASBk+CVifW3NzfDzGOlDwTxW44zyl3thnuvdRE/CUAD0GbP5TPr/mE?=
 =?us-ascii?Q?6Aod9+kSuOUVL+6vh9doxa2vvw4UjQDyGu4daVsby2b8p4y52Ts/fDuw8Roo?=
 =?us-ascii?Q?TdUuWvtLk3dAMVbar3M+AC621iwFIyXzT2EU15z4IfR2Ym/aEkGyuz6DMXQ3?=
 =?us-ascii?Q?z5sNRUcB2q6KhWkN/pnFYBQMKIK0vTwTtGm5Bo4ttBnrb6Csub6dBhKe/0Lw?=
 =?us-ascii?Q?K93JZGtJ0dXZmkDMohkRmFO17Lh22tEgij1LFGdoaF5zBCSuPyTuN1zJ2x3F?=
 =?us-ascii?Q?POEkBX+Mt4iHrzagIMwEEgI4IRaEEd28jNVWgk7Bjn5aaN+iFwn3VBEEcTIC?=
 =?us-ascii?Q?7Mru3cfHvaDnbBRJrt7uNi7M+GFDfWBXjRVpFZV9BG5z+ZZUacr+KtBUjqdd?=
 =?us-ascii?Q?2ua72Apqxc5MUj6QIN2tv+wldZl8uHFdCJC8EH57QGxzeQhxPDsNcJmuCyU4?=
 =?us-ascii?Q?EZtB3rufOO9OcjqjVtQFqvS9Po85vxHEwuYhSV2mEVTGQkS4huNHmJfpLsDz?=
 =?us-ascii?Q?95RSaMyu0DZJ72vuVMN8P753aG3WMnG7ChOXlSNUIfSoS9Brz+Fu+kcEWbek?=
 =?us-ascii?Q?1R1KOX/IaY9WhHCLzs0ztJtzCROoAqoRQDoDVTX8CtgvSQDhtjtxI1PkRtN+?=
 =?us-ascii?Q?ODXrAZsKy7/Ps53c5ppzw9xP9J+zwU0WM3R+Q98CbwpTBG0CuhmmBhlRxX3K?=
 =?us-ascii?Q?QIDyj5kD5575oEg2IUPQr6ptG/Bt7mqz3Gjlhdxk5yQko1N8VTzOqISyGQGr?=
 =?us-ascii?Q?4EVvBcSkXVz80b3yxg44gmhNbzM3kYG8GW7Huu0YuYc8Ndr/I561ez90yeCs?=
 =?us-ascii?Q?uoO5PbwoYQQhtyTXMZL2b6aBTsk3hfX/y1hSG2Cx8yhQu76mewPhDNrc3bIn?=
 =?us-ascii?Q?UhNLGDWpdCq7YFlcBIAj48GEtdvBZyJy66pmtr1oqFdVhMEojEvzxIGp0qsH?=
 =?us-ascii?Q?60BAlo4g0hW/Pv5chjtryLutnbp3uaw5+lpkgCWVQ2aLEV/S9Hl9LeTCsVUc?=
 =?us-ascii?Q?tPpUz4BfdlCSyE5oQvDBywgP+5otU0hSM47K/7FdJfRU4R/aPdMMSz+8VuBS?=
 =?us-ascii?Q?/di2kTL/gVFKd9xTrSgcjVF6wed2NcsTORUsAAIjqW+lSBVMFDdELmrigh2A?=
 =?us-ascii?Q?+Pp0XBKrECGAtuPzNMH+ahvQW+8C9iZzidfwiH66Dw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9eJSk+OCBNtR3bnQq3Sz0SIlIvS/gtB6c3OzfJeUK8CtIWytNvqaIDHXFEb9?=
 =?us-ascii?Q?kEd2B8tLxQI9Imicii4PrgBp09CgkBA3W53q8p7cKkaOkral3DPf69gYvrdD?=
 =?us-ascii?Q?JnZVx0fcQFcHYbZohspbXrsAJeSaSoPROg+hhFokw8YMsI+nfSqMHBIb6X/f?=
 =?us-ascii?Q?d3Whn1faX8+yCERt/9xadR68iZcG+zprbpdhhZM8hJvaMeq1rrTMQcPY3JkY?=
 =?us-ascii?Q?p/Isc/t8J/IjZqKwkcDfGvFBj43KrsSxHIIclt0xllPRp1F41tsBgAjs4NH8?=
 =?us-ascii?Q?YjIHGgchTmOnKnedDJZ95wnYvNo8bLgJ/Of2RSZkb4uDWEdnAB3YZHR1Ce4t?=
 =?us-ascii?Q?MEOp5r3j1dErO98BI0g4LghqRwd3TIQbPsotuZloTRh3XGgvWD78YvQYRCS1?=
 =?us-ascii?Q?dfbbSSPLmKa1sArsqEyN4czc4qLFHp13vv7k6tTFGdvivW8CcRN7732wosgj?=
 =?us-ascii?Q?gThz+LzZ1zMCupBXQh83b4vqM3TU8cSVRC6Z8vlQLXYYL4r6OA31zUY1mcH/?=
 =?us-ascii?Q?o/14lKVzVEpqxPZTnZFNwIpDBnQHw838ezxNgFcVCYH7wo8fw4YiRxXAy/4n?=
 =?us-ascii?Q?kd+gmgenb+1AtGxWJmDMffEYp85QxRiUZWmfXfZ/ViiyJQvSCjuGDGvpy9uc?=
 =?us-ascii?Q?wHHh4BbkAhiturD7sYUKNwKPon4FmDhOqO+fu9D3NPvlbZNH2YBK2OndCLxY?=
 =?us-ascii?Q?L4nDgkyZRVKWpl/t4Gr4cpJ3K6MzLAhR8rtZ4UNQHCCkujYwUMYtwduCtLuQ?=
 =?us-ascii?Q?iTAa1LeUqK2oVvzOwG1Mn8eBFNhDF0QVgrCLOU2vQ1oeSmo8SYSKT1PsdjT2?=
 =?us-ascii?Q?L4HWJr7MRF3BJzv3SyaClSbvFfEHs6YrX9wJZmVBFZTtfbEdYVEzzYLy9/GK?=
 =?us-ascii?Q?ptjRgn15iQoYWsnrMOCtTKzOWNfB4MtKNjWLvhErvGKpGXN8OES4T3nnJNYS?=
 =?us-ascii?Q?mABdCGSArKOvuzZNlh9GzK1YPntSWbl4+0a213aIJw2vHVHWnAArYSpyZKsn?=
 =?us-ascii?Q?oxH2X7sU+IMii9lVoHDNln8qNI8KHwh8LfJt6v8na02gJ6Th6o4gXr7+Mggp?=
 =?us-ascii?Q?V9/8Fii8aW5EqTc4PsYNb7vXosrp0CDOBLn/8Kx2TGyiI72kMhZ+7xazmkbE?=
 =?us-ascii?Q?tXl0moxdG45sHwvXIb1Yvefj5dciW6nQLH60ngkQ/xILJzv2mXgvZCnSDHQM?=
 =?us-ascii?Q?0LMv9zZLxYXzgzKa4StaJcmpKVK/UKK2uONUScwanHv6spAnI6hHconA+uWs?=
 =?us-ascii?Q?F/8quP1vo6kpPnYfeT2p0ympXvX8m/b1ESNbUMYFmtkktr3sDoXc4bwSfXKf?=
 =?us-ascii?Q?4S07Ny6shWQEMP3ShMQU1loLZmpmEy1a6P/xCgGgQf4n8J9PERiJQ6AomEEy?=
 =?us-ascii?Q?1OYVeGS6sjgttwVSC1wbWkfAbscChkfC6ksUmRCn6LTQSbbsqEhadsz5YTgP?=
 =?us-ascii?Q?xmkcVMBa0x9PZJrWAXNd7ZLKeTbxt21rIYxLj6xnfD/Gy7Irr1sXSR2eJ6Th?=
 =?us-ascii?Q?WLpG3Bf6DJ4rEDcF+gR90grxSe257x/PclYDdQQ49T8o+sBQe5lfo+vMSnKE?=
 =?us-ascii?Q?kDg4tTgWhVFG2G+U/GL7UewuZRdDgggJzLEjas7WPUM3nCRhS4rOuCgazgqM?=
 =?us-ascii?Q?ZLmfAyQGtoe2N+/k08ZLOqo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TwGCnWH0eANqaARY6CYIluM3Hi3S9Cjemmh+CeYyL7L7PmdvcCLTkjXQm7QPbV/m8EdIG1zh05TIbTr3XLkBP46vgkdkJQRTWuqzSuXHeRdbwgfH7603Guf+zOeS6MDnuvr8xmAYZzEuiY4ulnw3XqJTGHSPcCGCss7Ig1SewMeozwwmwZwe0jqm/L7dKSNq5z1Ke0pGfYJbtT+mW4KCm2qdNv8L/XGUZYrYfkIWOsyLN5ywh7LedBTibKMZDp/8dkzWK8SiLqAr5a/x1+eH6Z3ezUbfkaHhJ9dT1I1UEg6Cjo9CnYHN91geO4Idhxdi2mMIUdZG6Fn0SUtenIQzibnLu1OtLYgliLVHEp2em6I+H73c6jDcbifr085E3sJ7ctNkhifoqlvDU12AJx4E/1MPEBIQEU/TB4DxZkG7JRLuh9qFp0BLxtAUguJq9G5f8O61qKtiVufYCDjh5Uw5Mz2i+jwrA17Ruz1K4ku7PuxcJZ6t+LwoFrHLTcdiDX+1RGEckT76gn2y6vL/grfrlEdGw1hbDgcJehGbanxazwNU5Z2s+2dqW9qMa7IdbPCp/8BcFoMgrxhqYxIis8Sl7MCUL5mtKiU6ehgq/ZDjK/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4798d54e-fe60-4850-5813-08dc68e5a323
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 07:17:47.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUzJyHJaFY4rCAsFFEorf9A0ZMpW1z1YtTnetc9a3uEm5YZ+HAkOKztYp1q24c5FxaYS6O4kbPi2JkEBvcFXq6NPSX9r+6UmxMIu5fEsa0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_03,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404300052
X-Proofpoint-ORIG-GUID: u8wWIMxUFMuey10jmdJbXH8GdVYuKFos
X-Proofpoint-GUID: u8wWIMxUFMuey10jmdJbXH8GdVYuKFos


Eduard Zingerman writes:

> [...]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6fe641c8ae33..1777ab00068b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -13695,6 +13695,77 @@ static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
>>  	__update_reg_bounds(dst_reg);
>>  }
>>
>> +static bool is_const_reg_and_valid(const struct bpf_reg_state *reg, bool alu32,
>> +				   bool *valid)
>> +{
>> +	s64 smin_val = reg->smin_value;
>> +	s64 smax_val = reg->smax_value;
>> +	u64 umin_val = reg->umin_value;
>> +	u64 umax_val = reg->umax_value;
>> +	s32 s32_min_val = reg->s32_min_value;
>> +	s32 s32_max_val = reg->s32_max_value;
>> +	u32 u32_min_val = reg->u32_min_value;
>> +	u32 u32_max_val = reg->u32_max_value;
>> +	bool is_const = alu32 ? tnum_subreg_is_const(reg->var_off) :
>> +				tnum_is_const(reg->var_off);
>> +
>
> Nit:
> Sorry for missing this earlier, should we initialize 'valid' here? e.g.:
>
> 	*valid = true;
>
> I understand that it is initialized upper in the stack,
> but setting it here seems better.
>

With the last patch and the suggestions of Andrii this code gets
removed.
Should we we keep having this small changes? :-)

Also the function was left like this on purpose since the original idea
was that it could be used multiple times for different registers and only
verified once, after calling for both src and dst.
It was in the context to verify that either the src or dst in MUL was a
const. That was further relaxed and aagain with the last patch it
removes the argument completelly.

Hope that it is Ok.


>> +	if (alu32) {
>> +		if ((is_const &&
>> +		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
>> +		      s32_min_val > s32_max_val || u32_min_val > u32_max_val)
>> +			*valid = false;
>> +	} else {
>> +		if ((is_const &&
>> +		     (smin_val != smax_val || umin_val != umax_val)) ||
>> +		    smin_val > smax_val || umin_val > umax_val)
>> +			*valid = false;
>> +	}
>> +
>> +	return is_const;
>> +}
>
> [...]

