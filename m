Return-Path: <bpf+bounces-40972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E39990A1F
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C0D1F22584
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 17:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ED71DAC86;
	Fri,  4 Oct 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dFfKFeZv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nf68GGcF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111D1CACC0;
	Fri,  4 Oct 2024 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062809; cv=fail; b=nuH8CN//i7tDKJnlrj/5tLh3C/kckJ8x7g1sec0mNGIKD7wmrqH+AIScNbF9bw3ZtsK/uPPKRhRRP0RHEOzm5ZwCw3uYY66qoQglRzknmyOAxuwn0QjQUgApKNofl2LKl+e3pkxWwA331K5h6Qc48tudC6zMWOSoXNkanE+E9t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062809; c=relaxed/simple;
	bh=gPXy7eHE+jqm5IAgFmJ15vl09p6ElsiYMpj4/JeOjoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ASzlFe52/9FT6ZscWK7HPJ92IHSxGNAwq2hgwn/HsaKLq22LJrlpykZcb+hTc+iWCvCa8giw8T2MlGXcxAET6f8O6NrySrmRdkV28wMn9GiDnLFH3t4n5P8tB8VvE0joAXdYCbd/btW7CZvBMGrLPTSMCQo37K4V2KMp2gbN0KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dFfKFeZv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nf68GGcF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494GfwCj007029;
	Fri, 4 Oct 2024 17:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=2noXyZdHFGQxNvBGIxT+qKvE/2d9IrmHjpZUcDpl2gs=; b=
	dFfKFeZv05JEak7zuwk+zFtdtJqxRgr+0RL18TVklkO6lwBXax4zT1hTV/fqO101
	1F90gDqf6uaTI+TVHNhae2ePWf/cdIBfuUyKzqjHJ5QVZgdgVeYWYQcnV4ihzuU7
	4boH8i8iil/txxnVke5/lbgqgGsuFYp0XRSiJBpG2LSTxrpVVfIj72twK+HQvHei
	DPn9Ml54/D4VKkg6mVMaRKnyshHnYnblTN5EkrG0ijExa9ZnM5shxL74cbimUjMi
	j6HN2fm5CVoBtD1AlF03KGQHg31efQ5N9l72UxeBBz9xYvs/mjA+SBXq3F8cis6V
	xcZABD/UUyu4o6qBZ4eyTw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422049a3h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:26:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494GsSqc013389;
	Fri, 4 Oct 2024 17:26:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422057v1gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:26:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjWXilhKjL0ab7ohR/BUFk+k/CPpkscuFSdtcZZSNzegFUfPUTP9bBp/7x8gByqY6ICQkGsRpnSQDgevcS1ZFr81PnBtkFy5qJ27xhZ0ouZ/NzGnk2YX2Fay4wAlYjzA5NWgsKTCd65qiBPgfVpjm0vKC55fnSM0Ndgf7AZS1P9c2l8P/jg3a077EwzaSS8uv8fH+JKjpjYWpnD7wgwSYSGLU1LnzuPYkGVYFl9/MaGYRrDmy7w2lt5Fp7ma9Ph75Vq8znBhuGJbeUBJOmrsKf/HXSh1GKGGRe1xWQd+6UaO60yajBJODqs3HllkRdqepmqkxqShWZBKrs5BgOeZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2noXyZdHFGQxNvBGIxT+qKvE/2d9IrmHjpZUcDpl2gs=;
 b=eqJyymypa8fu3kEqX9aEqW20ezgUQ+Gy6g8v5rrzftgbIl9u0hDiAU/+xxiX2YpJcahm/Tojo/2JpO8f78U8YCv8+FTfY1CTqU5ELjsB7y8Vava7O8tn8TSwcN96eqWtrHMsZAfXuSHjGMUmampkGnH4g9hZr1CISch5mp9TnMErC4Lm3vJabMaMuQJb4u10ejqe3Cz/sS8BnWE7SVeNfY4/9AgwQ1A5YAfTUtKLutnSIVZ0cAiaMxMCLHeYYdS/9tuBxr5rxbndV9DH81TsDvehNHdjpBM46I/qYFKXPiECaVY7NnM5kikNG2bO8XwmMQkxt9un7fDkFcudiQJ9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2noXyZdHFGQxNvBGIxT+qKvE/2d9IrmHjpZUcDpl2gs=;
 b=nf68GGcFYDEZCWKpawb0TEkaSmkiigNZNzh7sAQKjJTBDerjLIwSXbgeXyyF6P3Ir9EQ3tlg3Y2jKkTxMlhOMS4r6lNMEyu2s5SoesF4jcuJId1NDHcr5iLHoV4EDAR5qk7+2CGiHPhZKQa1H7yRHogCBRkHhs2YK2UseMfWKP8=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by LV3PR10MB7745.namprd10.prod.outlook.com (2603:10b6:408:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 17:26:38 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 17:26:37 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v4 4/4] pahole: add global_var BTF feature
Date: Fri,  4 Oct 2024 10:26:28 -0700
Message-ID: <20241004172631.629870-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
References: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|LV3PR10MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: aab1d693-8788-4265-d9ff-08dce499b3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0a63eNXyRJpStlBjYkp9gfE08ZCpN+sbwHbUWaQ7q2vKks+C/mSP4W5HwfTq?=
 =?us-ascii?Q?5kS6MrCLLVjleP/jDegKrSHEUIqdcpi1iD8YeaxjCFI/fzM8BcAgW/3JnsKX?=
 =?us-ascii?Q?mwn6nTGKz8GW+L7OBUNgws1+R9p3z6z7R7iI+5R1p74uo/PRtL3jFLzjYUxD?=
 =?us-ascii?Q?naWV7UN2/bXlWbHOwxIcSllUHHNr5J86gcZ33xJf12kFgkxMBcGW3KvAPVMc?=
 =?us-ascii?Q?uVrc08WSMQRC8UXShjgXkbL60qDz9cI1ZT2gpeMd/oXBAwdgfRkpmZfgUHDS?=
 =?us-ascii?Q?xj8HLrPdZNXcIFvnTotT/Zf7OoWdaZZYKgZM2uzp5oZH0ik7BDUa4THoB1dm?=
 =?us-ascii?Q?K0eSUKJj4mGGEVuJNTswJLHqL+yeiKbxfZ+NuvjIzHnUCq4FUFWCcMoUZNjZ?=
 =?us-ascii?Q?CwywCe7l1AjuJzZ4nxMmEqmt66N5b6VrgLFgZKNlmDMRxDQa8KLBwaHTJqxX?=
 =?us-ascii?Q?BAShhTSBtE4/CPxzwc084Mi+zSouERfT2/FKIkYieHcclQtxhdOeMQ0sky3m?=
 =?us-ascii?Q?NVeaU/gMUzh2972PDpZIBR+8VD6uOKe2DMKY0Y0DSO8boUEcpBHnG5XlMzyH?=
 =?us-ascii?Q?uifThQsvwnNyBeLjsJw0Wm6Pq4aISADgSue4MiyeMl1QAh59kDxXjF+Y/oDs?=
 =?us-ascii?Q?K4fPEtfNhHeGY9RSC3pfUkBIWMoEFPpTfQve2ZqpwTr2Ni4wv3o8trup1+3V?=
 =?us-ascii?Q?mkPcQVt7QQ1yzKFZcSGk7N8CRCor8lMckR4xm2gI4SXnfU2ZSdfDp6KTGoXJ?=
 =?us-ascii?Q?rx8lLcKQ2QnzKjbbay6DYjcZL6i4+3vgffE/dXRer/rp1yiHOSArVGWUGK18?=
 =?us-ascii?Q?jiuh+vdmgVi9iiZi1MVdAk9F4TnlEx5Nl9JiikvsSWqlRHtIaYJTCowsCVGX?=
 =?us-ascii?Q?HJx11znAjrX8ZnCPWHL+vWqys99hCxoZ4pIM5Sh+6IXjlhxU4ulBGSLocyT5?=
 =?us-ascii?Q?sZWjXBCjqNWcSvQkO/QGtbknv+/tBZ1zz10So+wg9i7B+YVrsz+KyQEv1rD/?=
 =?us-ascii?Q?oMinFjo5pM6dODn3r0zM+xsck877edmSJb5irsOJFh4eGTeL0EDSRHspNkMp?=
 =?us-ascii?Q?fbD9TvyR0usyPLlwou9FTqmpvUoe/vMCIKZVAbLKZjpzUS/WnQkbwT5ZFvg7?=
 =?us-ascii?Q?gO7Ju1YC8suo6qTRYaO82495uUYBy+Sep4cY4fApDi3k3dQk+4JhzPRUnRpJ?=
 =?us-ascii?Q?GuhQ9AOcHmlw+PecrZpq5e5rnUNQUKzE4NoBdKqHg4EP8fZn6rlhMneQsnHe?=
 =?us-ascii?Q?Kpy8M85w4BMzdtGYBehNmS3RWlYqqJGDav4MM0u8zg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+wk5e7Gr0e5/OPmQvG/KTOgOEILg+RqPw2YFM91nmZb45fQlTlsMbj39PnP?=
 =?us-ascii?Q?uQYC0AyRnDC0Byxsmglojklfg0/6KfRrz83xD8+Ln5FUKo90QYTlZzZIYO7/?=
 =?us-ascii?Q?0LP5aKG6DQWpguZIMoujS64kIn0UHTbJFMGKcj0Y/yYZai1qgSvhz2tJUQgL?=
 =?us-ascii?Q?89fqoWK0EVZ8X4tfOLiXL/hKmwyXSqTx2nUPG+oXykMMaxft9LvI8LNr0K3E?=
 =?us-ascii?Q?EHx/1dLD24DGPFQueZdpOI9K6A0Ojx29+2sR+fZZK+P6fGqRsqLTdmfxNxw2?=
 =?us-ascii?Q?jSsGVDl/rp0+UhdnV9GNCOFbCSh2pybtl5hS0q6DF78XTZ1A6lHWZF6o+tHl?=
 =?us-ascii?Q?UghOsGsUgi7i2jejpJIxTemc4YQnvGp65d5I0fQ88XlfJSNZmG0SU7cVwkt9?=
 =?us-ascii?Q?8i+aZBVUrjhw1x7wShj1990t5jPKQ8M3j6qwISUOzg/D4LpkFFjWh/Q0x38Q?=
 =?us-ascii?Q?Dx186g+DPaMAkZyLqFpF/cwbxtgxvzTPUE02J6+1pk0Y4AkwWJux25WdbcIK?=
 =?us-ascii?Q?HOdXbxKT3AtVa1sIqeHrFIOIfY0TFErSzbZiZETUEoaeBtfyygQn4n9howJq?=
 =?us-ascii?Q?xkkgRnCAbUQZQYx/6gW30flo6LRw6JhJoCOT1JhVLbE0dXixp9O2Nrj8f7oo?=
 =?us-ascii?Q?16YVo9tdSXSrxojoUwo7wiEiGar4njSisI4fIW+YMg9q2ug6k+Gxcmw2ofo2?=
 =?us-ascii?Q?zoJHjwsWQN+vRAojU7H1dQTH/TXXyWKeoITK49A2AP0RlFM8CBk0kf6y98zc?=
 =?us-ascii?Q?YNObqZI5rZLao8uSUkQbLY4kZn1KUmmEFyoUtOW53UK/eYevpIwQojVZEyow?=
 =?us-ascii?Q?0dHpj3PbG84AcIXa2uQtv32OCVRMFotWqT2BLzsK3pxt0B0875yZGMmP5I50?=
 =?us-ascii?Q?2CFUehJ92R79qnQNy3tiI1fgHGI0XC25rxr1NpMiyzOMsYJoPkEVD4uC4tgL?=
 =?us-ascii?Q?7UC3njXp2J5gRQb4pVJucXN4k9QqlUnEvWeCY8DfwKIxKGfMO1hTuPubRKg8?=
 =?us-ascii?Q?11EIMdlJIdIzkL3TgZcZU7vRwPLlQrjTwqGnVbTJEcK0Asy2qMqo+PM0biG/?=
 =?us-ascii?Q?+REddA6IveNWcaIABAc3h+XTLQAaMJnKxyFszwGJh/amCgqdHV6FeUenXCbL?=
 =?us-ascii?Q?bnFqMynzfPSIqVg4GNm1VpMeLUw2SsPtEATuobF2UF5J2btvL+4WwJs/Jmg3?=
 =?us-ascii?Q?5WYL8g1HgsawPc1o5QBE3CRhbSrDK15C2iL92xO5kJCZQTgD+qB/8v/tidmg?=
 =?us-ascii?Q?cIwFOjVo7VuzGSviyHCZFyEo/tpif30vpKdDrqv0+8KeneeZSxqwgutV+Uk2?=
 =?us-ascii?Q?SI/f7fZ4FSrLwAfq8r0sZB0Q6AdL2x58cfMXbS1aBLm0SKEpQphGLppoy+zY?=
 =?us-ascii?Q?0LchQ+Tj3YgGLoA8Ol9WlCgACoJQa1slvf8s9IKWT4ARLDm7S3G+k7sOSQp0?=
 =?us-ascii?Q?VNgoSvuH6JIdjQIgbFCATvi2RLn2/uGUyz5CLjqlJUsq2Uvp8Q/x8j3TasB4?=
 =?us-ascii?Q?9LTtiWYtY1Hr16m4CFMR4+ivKxe8sAGx3ekhKP4BVTr4Jg2uF4nbOYGnWyG1?=
 =?us-ascii?Q?r+gz0cu1bs5Fs3cKCSTY7mszg5GYVIRA4eHEVU/YjK4bsrRmAGwcMWKqzD/W?=
 =?us-ascii?Q?M434bYp3FDuj38nMk2i5Cx0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TnVwDUiO+10XgFCirhGffQk7kAKVszuf+4PKtBeTGbEipGVTF2E6ZII+YHyNy39Yqa+OFUB0sz9uJrvFhB9flCBVszrCIBjCRim4LlXwuD5sMpADxM5ZwXoqmEDDTftyRS9YtJWctiYOgZ138CQXvORn4gByblDmmvNL+/3165e2s3oETO6Dr/qUsJYIeMJmwHx4MbqCYoTqJeYUWDUeVwesky0wU7Qknlt/rsb3NPg90mbIuWWbb/bDOOWZawKxWRLzmZg2/YwBtqQgY5zrjFk+L0QifZuyTRS5l6BO9ZXhxedERkPXqgozeF6jLl1o8fgkUCZj8G3uBo5dKQ8Zcy5Sbe1kwBvUxdX55NzBqJy7+uh1XAwgk++9AOVwyqz7Y/j3m6PYPOnkN7wYbO4hEzSVs7S+JAlLy3RuSESH7Dlz243OKRpbgw8m7pgyoZUFePiEgMzR0jsCxuijCdD19x8v6xUGAT7IpFfBXUp60ffKpip6mNOk2UO3+rXfNPXJFydFZobNUh06VMQX20o6wWtJgAmekSj0KRVDuzAjNOt2w/E7sMqPit/CoMdFZFu6+5BagENIjlnHE9GVishQLL55VRkZHWu3haVfh0NUdC8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab1d693-8788-4265-d9ff-08dce499b3c6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 17:26:37.8743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QE6rqgkq+0sUPurblpB8pLqx6D/Nd6qnbTk1EIefTluE+aRf/vtR9pFrQlwYTLOw/V31KArvzQsyoJX3IHhYsN6TUUyeicTFfqH2hZNSQ3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_14,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410040119
X-Proofpoint-ORIG-GUID: Z-I5AbmfxGEbCTlREknKXSekUljyU18U
X-Proofpoint-GUID: Z-I5AbmfxGEbCTlREknKXSekUljyU18U

So far, pahole has only encoded type information for percpu variables.
However, there are several reasons why type information for all global
variables would be useful in the kernel:

1. Runtime kernel debuggers like drgn could use the BTF to introspect
kernel data structures without needing to install heavyweight DWARF.

2. BPF programs using the "__ksym" annotation could declare the
variables using the correct type, rather than "void".

It makes sense to introduce a feature for this in pahole so that these
capabilities can be explored in the kernel. The feature is non-default:
when using "--btf-features=default", it is disabled. It must be
explicitly requested, e.g. with "--btf-features=+global_var".

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c      | 5 +++++
 btf_encoder.h      | 1 +
 dwarves.h          | 1 +
 man-pages/pahole.1 | 7 +++++--
 pahole.c           | 3 ++-
 5 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 838a0b1..201a48c 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2348,6 +2348,8 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->encode_vars = 0;
 		if (!conf_load->skip_encoding_btf_vars)
 			encoder->encode_vars |= BTF_VAR_PERCPU;
+		if (conf_load->encode_btf_global_vars)
+			encoder->encode_vars |= BTF_VAR_GLOBAL;
 
 		GElf_Ehdr ehdr;
 
@@ -2400,6 +2402,9 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			encoder->secinfo[shndx].name = secname;
 			encoder->secinfo[shndx].type = shdr.sh_type;
 
+			if (encoder->encode_vars & BTF_VAR_GLOBAL)
+				encoder->secinfo[shndx].include = true;
+
 			if (strcmp(secname, PERCPU_SECTION) == 0) {
 				found_percpu = true;
 				if (encoder->encode_vars & BTF_VAR_PERCPU)
diff --git a/btf_encoder.h b/btf_encoder.h
index 91e7947..824963b 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -20,6 +20,7 @@ struct list_head;
 enum btf_var_option {
 	BTF_VAR_NONE = 0,
 	BTF_VAR_PERCPU = 1,
+	BTF_VAR_GLOBAL = 2,
 };
 
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
diff --git a/dwarves.h b/dwarves.h
index 0fede91..fef881f 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -92,6 +92,7 @@ struct conf_load {
 	bool			btf_gen_optimized;
 	bool			skip_encoding_btf_inconsistent_proto;
 	bool			skip_encoding_btf_vars;
+	bool			encode_btf_global_vars;
 	bool			btf_gen_floats;
 	bool			btf_encode_force;
 	bool			reproducible_build;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index b3e6632..7c1a69a 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -238,7 +238,9 @@ the debugging information.
 
 .TP
 .B \-\-skip_encoding_btf_vars
-Do not encode VARs in BTF.
+By default, VARs are encoded only for percpu variables. When specified, this
+option prevents encoding any VARs. Note that this option can be overridden
+by the feature "global_var".
 
 .TP
 .B \-\-skip_encoding_btf_decl_tag
@@ -304,7 +306,7 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
 	encode_force       Ignore invalid symbols when encoding BTF; for example
 	                   if a symbol has an invalid name, it will be ignored
 	                   and BTF encoding will continue.
-	var                Encode variables using BTF_KIND_VAR in BTF.
+	var                Encode percpu variables using BTF_KIND_VAR in BTF.
 	float              Encode floating-point types in BTF.
 	decl_tag           Encode declaration tags using BTF_KIND_DECL_TAG.
 	type_tag           Encode type tags using BTF_KIND_TYPE_TAG.
@@ -329,6 +331,7 @@ Supported non-standard features (not enabled for 'default')
 	                   the associated base BTF to support later relocation
 	                   of split BTF with a possibly changed base, storing
 	                   it in a .BTF.base ELF section.
+	global_var         Encode all global variables using BTF_KIND_VAR in BTF.
 .fi
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
diff --git a/pahole.c b/pahole.c
index b21a7f2..9f0dc59 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1301,6 +1301,7 @@ struct btf_feature {
 	BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
 	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
 	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false),
+	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
@@ -1733,7 +1734,7 @@ static const struct argp_option pahole__options[] = {
 	{
 		.name = "skip_encoding_btf_vars",
 		.key  = ARGP_skip_encoding_btf_vars,
-		.doc  = "Do not encode VARs in BTF."
+		.doc  = "Do not encode any VARs in BTF [if this is not specified, only percpu variables are encoded. To encode global variables too, use --encode_btf_global_vars]."
 	},
 	{
 		.name = "btf_encode_force",
-- 
2.43.5


