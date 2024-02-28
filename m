Return-Path: <bpf+bounces-22952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EB786BC1C
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733A9B257CF
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5056C13D30A;
	Wed, 28 Feb 2024 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WmL+yyCg"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2937B13D309;
	Wed, 28 Feb 2024 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162500; cv=fail; b=X5vxot4usuQO+19s+DJpY2G5P5mnLHQuRdWSqdsSr7IfMbpwfvha04hQxGALm3UNz/BmCTGv/jxQ45TE/sIleFQB3fEnTPsn2ae1MnII4r/Kc1dBecOnRJQYyfHzNCEW0M8z8v8T68IEGNfPlgBDeYCadSH/xK2QIgRnYQnc35M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162500; c=relaxed/simple;
	bh=/nrRsoAlUFqtQ4d025Dp/rXre/CmFEjsHk/2TP7kohc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NzeToGahjbQ/C12wtFA+xDnD07gRLNDyxp/tj5XKmMrwddrznnZwzNwGEG4gkhYFggeQyvKafFW2w0rBDpVAuqGNN0L3jN/FTGV5Rwono8S8fIo5skcyu6ZAbL/YXssUz7z9B8wukOb+VFyXN3k/8qKC8689Lt7iKseNpWFPdNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WmL+yyCg; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAvZWnI1Gyyco+SUPZ+k4bxF6yPbUbsITqt65chS4EQWkoqAEkZKcZ0I42Q/y45lgmtsKn7NfhCqA5VpDfGCkiqDpIT919WH+tOc6hdZDcRK9+9kUYFVLZgCypJL14tM1+RyqGbhFmO2smY0IG4B1XO1jj/w5PNKBU23iC4QAVqHdNp9QKd/tb8MxM38HMlwxKCXLzqgnfeNEASsCpme4Qw61c3NF5N/MS66zJp2qAKU/7BPPR0PUYZVt+xE7H3WeB6X6UgjlCnnrxZNEEYvXhTRJPnbyTyAn1X0dBX26XpNiR0I2Rv8ofnnywEzdOOSVKwuyAcEJdEWPrY8rGrwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP30zesC4LFpuf/rau2OWwK4E2s3EAqdEH9eyabtqmM=;
 b=LKhkCjUk2LOB1I8ipLBgb1MlVsCoi2sjO1+M6ls40rsFfn2IOuraJ21oNF5EqsAKwkVOkZthJCCa/6IHxSSXfuw9qXtozlRp8Om/C/CR+glqcp52crQYx0UGanYyYSC/LZgIjAbQ/uCo3j5XRTo7wRAgs22xHzcqz/LUFXSbbNKncBqOTvNv+bSPlyiT5NvVPRRCEP8ywoMxWb/7VDe3d01EA6jVM44aAnlhoMh+bzzJBkOc85QGwJgx4iEYVx9JXSmt3iYO0s3M1m7AI4iV7Tq060D3auFQhEgbE9+e6maNuIlo6sK4MWl+OK+k1wmMHS/djCEz18uafyi9gfJsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OP30zesC4LFpuf/rau2OWwK4E2s3EAqdEH9eyabtqmM=;
 b=WmL+yyCgu0CrNnhMISp+8hMY/3888s7SlJ8yo1/bAO9buZi4uuTL/8aBXjl8GZiCfutmx9mbtwXvaqhHYOJXmPZQ341Z1sp2bJPK3kquJXwbFV/XMJeHYt1RLko2wfucSQRnCs02KvPBPbR2/ONboxnNBN9/syFus/Y4nthx4BkLZkvhDeV+YlkwcCZfMOqlTqM2mhziugrAzYCiBupyekYGg8Hyw/gc7/uagy2ycl/yU1evpXn5Zf+M2oTNfO3ek9iP4oYNEfvqZTmVjBChDLN7t0H+NLlYmvHL+OoJnfB2ls3KLHFExJSLfqNcp2I4HFe/7Zt114fO6aotFxdYsQ==
Received: from BY3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:254::11)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 23:21:33 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::a8) by BY3PR05CA0006.outlook.office365.com
 (2603:10b6:a03:254::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.30 via Frontend
 Transport; Wed, 28 Feb 2024 23:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 23:21:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 15:21:17 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Feb
 2024 15:21:17 -0800
Message-ID: <983b98db-79c0-4178-b88f-61f39d147cf7@nvidia.com>
Date: Wed, 28 Feb 2024 15:21:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix linux kernel BTF builds: increase max percpu
 variables by 10x
Content-Language: en-US
To: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<dwarves@vger.kernel.org>
References: <20240228032142.396719-1-jhubbard@nvidia.com>
 <Zd76zrhA4LAwA_WF@krava> <856564cf-fba4-4473-bfa9-e9b03115abd1@oracle.com>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <856564cf-fba4-4473-bfa9-e9b03115abd1@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: c12c5228-d677-4339-aa9d-08dc38b40080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CyoZow8D8PG8Tf/YvnPgARkOImjm9qIwkziPkc1aWRdMism/j+Y50XLLDtScrRBSaAyXLUCroppp/ijqun4cmEH5DE55PY/7sPzbqyi0kv9EqfvjFouaSp7IdsoY9Fh4rorzcXoXN66mL6qmAGZ5HWztrqSNPEhios2p4cpBTxdl9nBVBMNue0SiSVkG/hr27CaZKjqZnxGgC2pzHlC2Q5XxnufxzYxk4GIN/JrB4TdFbSrYXnDrpTETv3hC6nbIStbtPQzcaMQGB8INSJKaXTyuIqrJgK34swIk+kF+5qDI/DRAYp109Shwb0IQVR17P+bDIgvDmvU7TTMr3+290T1B029M9yw2gotlgVMop1hI7GM9Cod8vHSq4FKkg6WxjMIPc/uuI+YcCpbl9h+E1CE5w4AWIZEU5KQIOtH/z7xrAczGiwwl4S/QXxfZZ+ssZmcvGvXoFDtBSynmezu5ppKUPHJs8f71KZshjqO5vqRQ4YgpLtut+XPDn12H6w+BKFbVauNDjeI3SXq+WE6i/Sa5Hovgyv+8xs5gVwKxvXpWLAGMMF0ewPoBqXJyHYApD8k+w2zOrtGYR2U6+HEyujKuBtGHuNdKM33IJ4P2GltPqC3he/fCyBeOssIwiZq4osM6w76v9+Xi6B4dF0V8pyLmpB6sJlyylM7D3egMmJHTVrsqFyrMw2wewzJPV1KM/O4ypIxSCtx2nd/l0RKp+/P5pJbdWtBic5+1HDGsmerTCKvi9PLs3wLbif5hghcm
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 23:21:33.2218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c12c5228-d677-4339-aa9d-08dc38b40080
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122

On 2/28/24 04:04, Alan Maguire wrote:
> On 28/02/2024 09:20, Jiri Olsa wrote:
>> On Tue, Feb 27, 2024 at 07:21:42PM -0800, John Hubbard wrote:
...
>> do you have an actual count of percpu variables for your config?

That's a very reasonable question...

>> 10x seems a lot to me

Me too. This was a "make the problem go away now please" type of "fix". :)

>>
>> this might be a workaround, but we should make encoder->percpu.vars
>> dynamically allocated like we do for functions

Yes, that's a much better design imho.

>>
>> jirka
>>
> 
> Good idea Jiri; John would you mind trying the attached patch? Thanks!

It works perfectly for me. For that patch, please feel free to add:

Tested-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA


