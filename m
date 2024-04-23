Return-Path: <bpf+bounces-27584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499E38AF772
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 21:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AB81F22D4A
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 19:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E51C1411E2;
	Tue, 23 Apr 2024 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LdmcwfoD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IAo2kSNx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2113FD65
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900983; cv=fail; b=sx3jsr3EWKH19eY/jBSNYl+cizh426I6qXKDefRHgdfa4LC9bPatShTivbPE/7Wz+CRzhc2ae6GmUml5+kAiGi0790fGyws7Cmxvz04BSwAk7sfw3+oeyoZ5BO9p+ZCTrUOlSgKCpY9UdBhA2Th2XGW3EYr7f/B1hYkOImIa3Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900983; c=relaxed/simple;
	bh=AxkpQBn8rHfFGlYtgjfqRlW0o6JafviWPmF9g6kcBWI=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=YhStEJ0EHiwQBznGLerFNwKRfEMz456vbYkAdCOegx3RFtAgLN4iC+KyHGZ2ozyi/bk2WrBxNu0iwmc9MO0FvDwk8crJpYBWGZnS1eGgvBi2RGJZUmZilEmJVTwzu8wceCCKFdj4QUHAhW/yUDHYrtG2dtVJi2gFhKKrKELGJZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LdmcwfoD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IAo2kSNx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFUOjN006559;
	Tue, 23 Apr 2024 19:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=AxkpQBn8rHfFGlYtgjfqRlW0o6JafviWPmF9g6kcBWI=;
 b=LdmcwfoD5Q55eNS8SAc3wP9eM2oph4VwGICPJWJQuOzsc7saoHWqSq6VwA0sj4ghCYF/
 L+G6tYl30i8LFTsX0XWjhm5vLWHjTVTADXMXpQ737ZQuHx2j9Y7hOcvUFqFza+vteg41
 v2AsVhaYVFtSf76tT5Fw4C3UQ1DYDuzVkdiDCl1WnJPNLOp6UZSGaDdzEQLqoi0ufgZc
 ZVHH3jblbLdNrRCiBlcISWLDanFaxd56OnKgACpBWKJaOJUwr1zYoVq9k9RTLJK6/5DB
 YSmgG0n0g7g+umWHp6M64Mym7R3bV2CHy6DrkPTGMnH7z7A/b4YJRhVbFwux/nFXKtXn Ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md6wee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 19:36:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NJZTr0035535;
	Tue, 23 Apr 2024 19:36:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm457sc3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 19:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwuZNWsaS60cIvrafQ/6uXmE0/0G/c/qiYg3DpTbjTIa2v19t76Lh0eG8Q8C8cQHgdtTYtHmiPQAIXBbrE0tSCqtsMZQtr2FgJhaIW8Q26MKrZUSNc+yUV25bBTo+HD6VaYg6Oc1oHAkCNGx8113G+PhoweibJqqpBqTrhzShRG0dwcCNgYHF0swWB3CB9lMxqyd8/C7cwTbaEQkMfNiMmpaUD1cfkA142WcNsdKpxQqKThl4hHNE2MWG8hdsXcFv2IsaU813CWwDenNxpT1bLSUZXI36dHYET8jiUSB453kN9HFLRimpCA/rwFIaa3kss3MuMF/2nM/tbTI0hsHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxkpQBn8rHfFGlYtgjfqRlW0o6JafviWPmF9g6kcBWI=;
 b=V9Cfn4UhppCF6lxgUA5EF2vsnvO8tXYQcVs74c1G7O1apChURPK77ebAUWaTG7m9u3jQtjsd9gZ2qV8KA++dmWoyGSuq/xPmQ6gZ38EePr0NvxSebx6iq/e+zoLGGKwLrrk2VqS/0ZWFaEHOukPcGDEVetx3P+SJ4/d9go6MXXzO0IYUIEzDtNbzCE4Qw8an76ih7WtOvpRTl2GRBk1oqzWrhAiqmEDWsvlYR4DFREss/03DdKzwwogUMuVejIT4odl8qeWOqfUt9I8igLRvrTG6zl3kiAwQXomLY0p/ByJo+G6Y5k1QLmRJk1MJS5cage+mbSzAU1bcNdv1VeEFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxkpQBn8rHfFGlYtgjfqRlW0o6JafviWPmF9g6kcBWI=;
 b=IAo2kSNxFENrWatEU78l5V9caXK5yh8GzSSyVvaxuql1ipL5NouqLrXdh7nb+N2dTlTKga30dI5A/PD+aFbQp1nWdcUuZezFq3MDswvxRRd4nxESNKddTuMnzmi0fHGfqo+4pCbabnFNl2JlrxU3IUh99lkXa9Zc0Eu6Dwn6QyU=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 19:36:15 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 19:36:15 +0000
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
 <20240417122341.331524-2-cupertino.miranda@oracle.com>
 <f347d6ea9a0d8ecb77fe13a89470195735c706d2.camel@gmail.com>
 <878r19k812.fsf@oracle.com>
 <047c972f71bf89a7d4004f1852fe498d3e2ad010.camel@gmail.com>
 <833fde942383aa4b306ee0ef75c1a5ebf212e02b.camel@gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
        "Alexei
 Starovoitov" <alexei.starovoitov@gmail.com>,
        David Faust
 <david.faust@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf/verifier: refactor checks for range
 computation
In-reply-to: <833fde942383aa4b306ee0ef75c1a5ebf212e02b.camel@gmail.com>
Date: Tue, 23 Apr 2024 20:36:08 +0100
Message-ID: <87wmonzxav.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::23) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CY5PR10MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 29cc292c-eeb0-4f57-7299-08dc63cca386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VGOhK7ZdUanzB/eTcw4gLvLOQ3VpgLTdqVmmsxj/+dX3EcTiivhoZLzccWu/?=
 =?us-ascii?Q?kAXE0nswjYF+WX2OVbQUxVOwMEzLtrwNFa4l+PYlBqKu5jKSDqUOCy1Ud2c2?=
 =?us-ascii?Q?92pfTloTqAP9si737A60Ftc4D4f1tL3a/yKMrFat2DdID1ugGcA2dLLf1TLJ?=
 =?us-ascii?Q?0GlpKaHSKwAJAjsrJqcpfc6XrTjO6xXIDJVvtaJvRAWcBTHENqOweaq2FYq0?=
 =?us-ascii?Q?3a1RmEGCsvlwVDbzkFTTaoQCOoNjpqzNh/D3e9/d+xuL2wVULXA+jI1wzBT0?=
 =?us-ascii?Q?azlxplaDP5hwoHx9LcsvyOg52FKYmMwN3UzDbabJdlC/+xooXiNB3FPTgT44?=
 =?us-ascii?Q?PZZ7fD0ferOxt9ftz9dOzNf/GwTVx49Tez1UH3lPK+xp6bhZ/7CstL0jXsfN?=
 =?us-ascii?Q?UKPSzQi0QdZUpK+IfD/hcO96mUhZ2Rz45NRovVWeKgcWrSXZN3ZWZJkhXk4J?=
 =?us-ascii?Q?HcIvyM80rYTI8byjDgb8SbjEMnz9V62AlZl76kunR7Q8HoZ1emOAFyqDan5G?=
 =?us-ascii?Q?BpmD66ZXCL6tid0gv7WSv7gFafFjUsAAHemmP4Z6VJtUaPgqr1txJqh+F8kL?=
 =?us-ascii?Q?o6DH9ZlM8SBFpQwlKP8PRhSclypNZuyQQP9anHcyccoubosm458wOU88XXhY?=
 =?us-ascii?Q?ziCIN019VKfLVYCRoA0AXAzlac6xuitqbXjxwRYIxCzv/rJz4UZuUE4/2YtY?=
 =?us-ascii?Q?K4iwIfNVXawXj/3inR6h684LV7UUiBF59IrMcMGDnYSMNES+a5rRytTxGqjn?=
 =?us-ascii?Q?Dfw5PMkxmMfrsRzvEj7gBbx7DVWoDeyH8Djn3Vi8iDCROW0qlTSUTq8j+yTR?=
 =?us-ascii?Q?RSjSewZa8pYIzJ9IKpY5GgYmBupJYenOCdGkxaxflOLPUnyJANraQmmAETfa?=
 =?us-ascii?Q?zLiCTgSbhWInoIUTm/OylgO6tUk3hhPyneJ9a6PInF7Xa/gZWWkQFe+1IFRl?=
 =?us-ascii?Q?GjomZcTbP0AoP/eUlpSUrgk+ZI96K8jJ1ZCTBA6WTTC7uqdLDaqDVadD+B/x?=
 =?us-ascii?Q?byTPo2hjIDCnjgz0fB+C4hFMQxSg0epC9euD/D8J3WJpWZAZ/Fr1tHVJd+Uz?=
 =?us-ascii?Q?kp52J0YMaUILahmmHIlBA87NSpdzCcbzhq9QzZn5K0JqC19iLZ/00K56lVcy?=
 =?us-ascii?Q?BHIU8yo4vOAQuJvplChjGpp3N2rd5PGYFeC37srGCpy3NnrMbWg16M+FNXlU?=
 =?us-ascii?Q?JccG4S9c8EVL6+RZM1Lj8aeLrBB6P+7zFYgH24CiM4s4HlAA/hzYI4Qsmng0?=
 =?us-ascii?Q?0MYIoXEY2UBM2bBv1bmO3kRK2dlZlNhKt+3aVM/fmA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C1JEfzJnWds2Qcn0UrJgats8Y8hzrEyqWcUn3KNOrpwuUJ9Ez9kl377GSfjU?=
 =?us-ascii?Q?6sVB6rzssAaqTX5uZcmGhNHeBkVNj2+mKfo2LEiC6VWW+WQHc0BH0sNr6V4u?=
 =?us-ascii?Q?PjtGMCrcJ9k6ueDOT2tgZ+skyMmSdhpBuJYHAIHGhcOtGRgzOVGrsOGZgV1/?=
 =?us-ascii?Q?s3EevMxDrD3LNVTAc8TszLVtOLSeBHHM0K1sZUZ0HOjY5pAdfZmz21DdlJMz?=
 =?us-ascii?Q?mJbM3Qxl/vmZykjLXPbK3sHx1/l4lVrJG93/mtGF229joI5GQLzrsa/iQW3R?=
 =?us-ascii?Q?NrYtDfO5voYBErIPqWviF+orv6JJBlVOKHh/jB4lKMe37J3FThj0fEmafzRR?=
 =?us-ascii?Q?RXc9uK+ukAczbhIuRBFQJTp8Ofga534313I3RSnzkm9uaI/Z1OpAP+3740zc?=
 =?us-ascii?Q?qUXJz13kuuLIlyuBE9mTLIsjOEWS6cdsryOnor4udF66rHphSMtD+2iqNhxe?=
 =?us-ascii?Q?Pizilu2GCsStishBY/kkRImYDWXV8VxotO7IIedUoL6V6T9Zz29pOKXeV31j?=
 =?us-ascii?Q?wdMP3/fNNbc15JhOsjKFw/un46hhAsaf1HBKDPNjGzi0fh1+ZAhJI0w7U57M?=
 =?us-ascii?Q?N22ycaRJ5JFr+ScbqKNv40PEXKLNEuhx1EZAXVlD/sQ7ECGAqVgPexIWj/Oj?=
 =?us-ascii?Q?caL1yelJY9nSJ6fodirWZPYcxm7rzJav3/pYJk2I6CgkVnXhaVbXNIa6mJBH?=
 =?us-ascii?Q?wvtaqpU+zDLgm5apxNv+z/eEZDeWrZwLSNNMK4WMyS+88iZoPqbZxQlEI1s6?=
 =?us-ascii?Q?UfkvOLj9v16CYcBkfMbbxSanhQ8UNiwcDTQGRcBEbLfNnaPUPmsRKsGbQDU2?=
 =?us-ascii?Q?wCpOllFv+tf9wro3hYMF+prGAWEELvgD3sqQuRSAHwqXGl/Ii7WXp0s9aYC8?=
 =?us-ascii?Q?ojBYnGk2kQG15W/jRUwkabIuGvFKqy6F7Nl1XiH9ymmVBWLVo6oYkbQBzJqs?=
 =?us-ascii?Q?QncBIA1ymhgQ1IykPO97nX8mph/t8WdTXHf7LosK51kDJgdZSQttFtuYhb5x?=
 =?us-ascii?Q?cuKIQjbDgedT9j6D4b27jRfVhQeZeuxPk0/rdermFXKWb0qGAey1vU5ondkJ?=
 =?us-ascii?Q?7Z0gBiq4VdrCMPyAiwsrRAwDeeNBiLkB+NOPun2OLE0uljgZxJcBwXKoL490?=
 =?us-ascii?Q?GAkAita8064Of41t8k7/KtTn8F0xlbP8TjaRzKs4rg8BjJffDUE+O5+tFUoE?=
 =?us-ascii?Q?T6mwdJsrbRj3XU4T2UMNhZZR6wJTN5mAOo5zUEivY/QdPQmHUGkLbblKOmJB?=
 =?us-ascii?Q?a12PzXWH46Lc4s1zxyGOMax3J+UsurHRmUwRjRzaYGIak0hz+t4uoOgn5kb+?=
 =?us-ascii?Q?14gI5Dny+/IQsHbFjn/ED6QpD1ZQKhG6L4Mxa/qCH0bgMa1a450dAK2i/Jcn?=
 =?us-ascii?Q?BX+/Wr5fiiRe3HIfixfaB0/C23HKct9XqDyEJTvA1axYFoZYIZo307YAOoG7?=
 =?us-ascii?Q?gAZhqD95KXQXggSFt0hkbv5W2q+ijq2iVZLraxJBYA1FMYMhq2i0Dq9KzvY9?=
 =?us-ascii?Q?Yq4gkUrj3C8mGosK0Fv3VkpG4z3K2EoySQ49r3u0xX0zNs9OrJMBDWZOGG7W?=
 =?us-ascii?Q?BelcvNMLF56VxDi2tKzPTH0xPo5ihzjB2XMgYJLL2+hGpmQDjrUYtgHwx8Ct?=
 =?us-ascii?Q?iLQqiFGALQ0vOdaLT9d/qbc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cvr9EBFvJS9nCyJDlOdap0AB+91OmOD3bcSXITvDFBt+mZuA1p9LK3d3kMnyCu51i94WNHPaUZir3tiyqPaeYJmL9+W+ftQsPV+oql8VxLuyrBIzP/eeah1pevlLF2uYjQpFGjas7dbxYZNa1Z+LnYpNkdUN2IHT3dhViqjt7nc/bEmmIpb3mkHYbclk+7+BeVeyGcXx/mqTopJHdRZ70QuddaBkBh5l8o0LFABXU2skX7L6Bqkvs7/y1SZta7s7sjsywB4EUoNFiqoczpdqX6mrCcUMPKIXJhjNz5ztyD/U40R1tokvRH/6cuHpdtmNhMXHFIFf3MURZioh9q3gIBEv+xGCpoK6QTQJCrtC2KE1v7PCpMJYz5gqjIyA9bLuKDARD20lDSGIf7qyK5043A94sdONFTG+0B7TEcJU91KSmj/RTM5cptuWlbC173BU7KaHGgAYG/Hp/EXXvACVnFgCEI7rcP5WwDw1iXuEYecGjChxYD/1Hx9HX1vJQ8yUHGheG4FPit4J4BSji+JKt7JwOZk4EmS37/aSG4eTO2b/Dzr0BCrI5K+1JzPOTVMSWPYJI2jM2afSfxddaPXaz7hVrZ+4hnsMOr2LZ6DLr/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cc292c-eeb0-4f57-7299-08dc63cca386
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 19:36:15.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QGRZ4u2V5Z+A9ZHQmpRjwzgRL6GpHIY14cZ5Aizrx/AE1tZWCFxCLJ8hGGvg6xPM7mL+D+SQusOwut1rnjE3Vs2LAx72g7/2YbXrgUebxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_16,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230045
X-Proofpoint-ORIG-GUID: S5w9sfk4sbJGG6AGpqtcdFhzFBUYB0Nt
X-Proofpoint-GUID: S5w9sfk4sbJGG6AGpqtcdFhzFBUYB0Nt


Eduard Zingerman writes:

> On Fri, 2024-04-19 at 10:37 +0100, Cupertino Miranda wrote:
>
> [...]
>
>> I was proud of the initial boolean implementation that was very clean
>> and simple, although like Yonghong said, not truly a refactor.
>> If everyone agrees that it is Ok, I will be happy to change it back.
>
> Hi Miranda,
>
> I've talked to Yonghong today, he is ok with removing distinction between
> __mark_reg_unknown and mark_reg_unknown, but he asks to first make a patch,
> that replaces the use of mark_reg_unknown() by __mark_reg_unknown().
> So that the follow-up refactoring patch would not change any behaviour.
> What do you think?
Sure, I will prepare it. I presure the patch should be the first in the
series.

Thanks,
Cupertino
>
> Best regards,
> Eduard

