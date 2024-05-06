Return-Path: <bpf+bounces-28680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4728BD00B
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 16:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0916B27BC3
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84DB13D884;
	Mon,  6 May 2024 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SUcUGw6S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h9oCPKI/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91D613D638
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005207; cv=fail; b=QS2D+ym+6xm+h7R2CXhnOTQqo1PXclAX1H0RgwFcREg1wIxpL7bvtgGk0BkxXlsEcWIp7vcX6TZTUIADdWXBF0k1qUt2Tp/MfKswVWZU5nqkHKdJSTdRRhdV1HP7yA8XodUgmEjb4TgJcbu0fifoV9iWi4b1XteVsx7qzv7Qv7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005207; c=relaxed/simple;
	bh=e9GZfrVZ9TWTBM3I9LNLdhOy6o5Ec44SW+IiH9NYMoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lHJUkQru6opa/nat2GkcYvBJJfs3VYv0IeMLmuHNlAcK04RnTTmWXuRIqfXNYcsxXS1pxgzQSHtgvrn+CCEbCPqDQZcxObjhFkGKJpNlxJKRXXtOdWQtpQhYmeIJkJXSdsfYB7Tu+Tc3YfD07kGVF4BD4blluDfHi+z0wNgkT3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SUcUGw6S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h9oCPKI/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446ApPnw007369;
	Mon, 6 May 2024 14:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=hYwwz27Zbukx3WAk8qtWHtwpOeq9/1oGhCzFI9Q94w8=;
 b=SUcUGw6SWQeylbZJUXmb9a42rKLI1nPC6Qo4PdQgwYjpJOTB1a7dqMnuhCwSJa1d7Bt6
 T3JzSyK1E7yuWJvjmc/1pO1fLAhkILtc8EUJk0iqrsCbmZ6zeVfFZYoIkAt1ZMTXtXLn
 kGqux07FMLnpq44ZGojSUhYFkVddRXs2pCPwH3uC8PpibaiEr3YuWxbYvuxs5yuUKOZ5
 dpYVoNiVD2R2SWZmK8v0odWSjdapHNKGVinTPAIye6iw9BL/1sWuOde/z/VEcWjpyIfI
 I7f37dhvK93tZF26R//pwcPGEqED6WjdRYirMpQJ9Uuli/8Q+e12RtqQZz9r+JkJhkNr 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcwbtp95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:20:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446DWrdG006940;
	Mon, 6 May 2024 14:19:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf6q5hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:19:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E052Qo6aHwpNZRPqMVDgso0qOGwhDjhdNQnFmEdpL8XX/lhYVW6O0H8epshKN9M+dihL4Hc9SRl2/BX+BPoOmjrsrvwcgPu9W0K95mtk8GPZ7bwjTMqjsAowjKRzLWjzbnRu5JdoMzXEepxc6sOpoAfGWO71CmkoM9QcON1891PUfhFz6KvC5D/a52Ye4iAzCf/NX9IQXokMblRi1HPfz7eOfEnJj7DemhvnZXS7WQVUd7AQdCJ1hanCLCRKmB4eZQuLHbMG0X0+M8KgJFdbwnx1MFICK0aXwB0z4dFOGurXLfcwk2FfSt4UnnfIa+BLzfRKPym2EJGeq4qjnc8jww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYwwz27Zbukx3WAk8qtWHtwpOeq9/1oGhCzFI9Q94w8=;
 b=gDH0EbnDR3xty0kSayf/AMUbAcXxayFxUL683/1DesasOkVLVgSRYIDZ8GSvjmu8urBOpPDtJJSQWTQwNpsPLUILtsOGvfDe2TeN//HYENUFfGUKlx+d4tbzUlfP7o3H4t9jYDroYW31mIM7nqYHFGzIuAv3C99hfz4KZmkWa5P92ZCVllE4NODbqvOPt0eKooxijyYvbXsb5u0CnKjgYv9ONMuhRcUTUU9jGqbg4cSjviTsar+Zh0F2jKnRJW1UG8jqX1Qua/N1oalYAsHwAQ8FfUYIMV1dss89Fg5ZQ4jJpkMgkGi3CILcyMRvmLG3zvqx7Jyv+qnzzhyZr0q5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYwwz27Zbukx3WAk8qtWHtwpOeq9/1oGhCzFI9Q94w8=;
 b=h9oCPKI/72nV8DKvHeRmTmk08ojgkwP9mgKSQ8pkfrg/ET33joUtTJ7yigXxDaXX15xm4ry7w3obD72EG9izy+3MP9s6Mcyf8iVm5CHBL4Pjt784H+II6p/7Ytds3URH8jy2wHAS128gA79YzWOP40NtEYzYSH3g5cyXkCXTIjM=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS0PR10MB7173.namprd10.prod.outlook.com (2603:10b6:8:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:19:57 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 14:19:56 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v5 6/6] selftests/bpf: MUL range computation tests.
Date: Mon,  6 May 2024 15:18:49 +0100
Message-Id: <20240506141849.185293-7-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506141849.185293-1-cupertino.miranda@oracle.com>
References: <20240506141849.185293-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0169.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::6) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS0PR10MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f964b6-c8d8-4deb-c4b4-08dc6dd79b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?z40qY0e0cZ0VZNvxoURzMmeFGsHrBOXWvx2H2oBpg1ULZ0J+F5Td8+VcVgok?=
 =?us-ascii?Q?V2DW7zxtW2srJbDKC9U+ooIQkavpzpsz6azQiTV4uUj2bDMt79sF5QHdd7g7?=
 =?us-ascii?Q?Wp0OEZQkfYkZHzh7sd3iTrMrNWZruF2a9HqolGMqXy+jXhCSTaa6uM+PmGGH?=
 =?us-ascii?Q?7j8cY3NTbwy4hNJNky7dr6IttBN8eZboZWFRwrgD21LM+c93jYUmtZ/ZGZBJ?=
 =?us-ascii?Q?n756llo8pJIwLqYTC4/WxLMhv/g7kLuiMPv46i4Py/VPWgq/Jj5/aVQjN1Bw?=
 =?us-ascii?Q?HHHK2r+dj+uOnTAUxmozZKqNQ3jx+IEcNbc8EEapmOXS3nX4H9KHXxwJA2EP?=
 =?us-ascii?Q?0he9HhWDYXZ5Rpo2Lw689YvxPrin1eAIhDYYUuVI9sqze+OLGxrFolSfDk6w?=
 =?us-ascii?Q?7Njnqj1UrVZnbUFN9PNhd1c34mgujjy0GtbdaPMbjgPdOp30Qklf7iGpb1Uf?=
 =?us-ascii?Q?AvJvTSatSQyorhn0QqujTH1BUjqSwdbKfU/IoKB4/wNix2n1M+0w/gvGhC2O?=
 =?us-ascii?Q?6VpkmnoWOhh0jKKz9L/bQApz+s4fxECwsovOtVldLRHprwD3n4IvkprommkD?=
 =?us-ascii?Q?/cfiRDNArwhK3xE9sqrFAikTjfpKsfBQid/hg34/L8/lAvcuxYNoTzPU0L93?=
 =?us-ascii?Q?GcqRjnoljvzLBdI7gY/SmPGAGAxHT/Y0Y3rTDQ/s84ByjtMc3vlDy5Xptebr?=
 =?us-ascii?Q?eW8KAvxzlcdWw0A8Q5JP55uOTOufZkrVWbUc1HMgD6yvawQpLFQFCrL+Dan7?=
 =?us-ascii?Q?xKCS+OKc0Va9+1XutOO+4Nq2/WGm0ZNSkr6E7Q1QFf3EjBs9K4/SjAAzDt/t?=
 =?us-ascii?Q?Rw96djXvHCGh5bIrU/pIbL04ZxoEWwtynfI9nf6mcUQzZsItXYaSXNck4jWj?=
 =?us-ascii?Q?jvsvBa/uKExD2SnXlB9p8SuStrxVjxaGqk6G0MjZgQHHw8qEko519/GBxfK8?=
 =?us-ascii?Q?yiNF1RMsy2q/Si01Miz5NgrlfKap81YXu8fjQ6PquC10Wg5FZkXIqP/eTOj4?=
 =?us-ascii?Q?qyuHQu0H0jrlvgrTu1NHSSsOkkhuJmbmnNFjvmFyMPMXHHzJbdOd+o9h4sS1?=
 =?us-ascii?Q?wKJ7wq1zW+Tw1lDU6qgiacU8ZzXunAsCiG88/jkG5SXbSFV90SDMi4ttsYA7?=
 =?us-ascii?Q?ixE5gmiQTWm/2vezbj5lxkN/nRLNCZY12lA/PvtJ2xObrdH5LluQGCCZ/hW1?=
 =?us-ascii?Q?P8au2Szqi1QVfM89XI6QmHeImTj2yntf3S1vRbTXzXUV1rqppmXmA7KnsTvj?=
 =?us-ascii?Q?ddXiIi1ukWVdWSOTOlCq3NJBO9YW37iX41+pt/l90w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fNxrNNYctSgRlMeYhtGdPsn9oE5UWXH1cmag/CkDkBAI4WZBv+AyXt0ZjlUb?=
 =?us-ascii?Q?yPY2HYyRywLfn3hNpj0zu0yDYy44OOo7g1ujKNyjoyKH2cfSzQemNbaZgqtb?=
 =?us-ascii?Q?g+/Q4yhnSxi+Hf2U2Ql3NdcCD+ymIRH+2D/9smDHqWmPdXnCMQRzkwbW31ao?=
 =?us-ascii?Q?M038ImscwTVAt7ZuIBbnCgTCuQEtvL8i35I2uWeI2979eVYAtK92AAmccQ8d?=
 =?us-ascii?Q?ZpQrbNR3TVO+p/tmE8tdYMgHK7T5jFD0qHIFmy1q68sWExg577Tow+iB34A0?=
 =?us-ascii?Q?h+NCEsHkP6cTM4aBwfvrTJ2aUM+EsUsuGsq8MY19nnAZNSU+68idS4zfaJbc?=
 =?us-ascii?Q?7czrjZop9C9Nh0jdu+6kkzA362mf+XDnu5oEd894GIIqwRwlDqJV9YBex4QD?=
 =?us-ascii?Q?3/nf3p9/UQ8bHIubPYQVhmwcVH4pcNgr5jd4JgGdDPCOIV+D6ljenPyKaO3Y?=
 =?us-ascii?Q?A79QDz9GHYpHh/Llxa8JN7wwsPgncb5Fhlsx02rKSt7eLo+Pkm00J1oFvbcp?=
 =?us-ascii?Q?31Hue9bbF+Fbn3iQGIBBpDiwLHDsorV0KFtLdA7hSWLmCRusnHzY2h1mQRHD?=
 =?us-ascii?Q?RHtvh4ac8xO7/hVOumkV4sYmi7pU4oMBF2PG7w5j9onDd+wytGnbzNufeSm5?=
 =?us-ascii?Q?N93KTTNxDTaPdEEGv18rqH4KxUCi2o7c36IZXLNcKxkAmHzEKOY15hnSiGMm?=
 =?us-ascii?Q?jDXUV78GiXLNr/zIorRq2M5UD47VCBrZ0xvfPNzA58VMboQ7Udb8dz5PAlPP?=
 =?us-ascii?Q?qYrIwf1GW5FP2g2PMPgYXD3mAzGcM+ZQBgJfCd2AMdGbY3RSX8fGdGTh+V6/?=
 =?us-ascii?Q?ASUh8Kr7JgHgF2r8kJqEz6Mlr7EHIeEPbscbFrHCV3OvYxs5JrUgB5ceFW51?=
 =?us-ascii?Q?AEMjgdGI3lE1FXZ3gJM48L1+GpT6/TwWooZibVLvoexW1hvqyIkGUf08/Bb+?=
 =?us-ascii?Q?umKwk0yplCMP0llX2PwNAkcfNUJLwt20MJJQwN9IGsceKjvfkznyfx2NRF3f?=
 =?us-ascii?Q?ULs52ZnYudZe487htUa2G6OkgAzbKAasmXeHmH6Eh8RgzDvvZlmx1tqWuN3M?=
 =?us-ascii?Q?inE/DBVwbtOGQBQ0qjb2+XaNEZhJSubhRNsUxssaKIWtsXCmPzjx9YdMLNd+?=
 =?us-ascii?Q?S8N1m5vLYMoEF4Ciel3MkgHnixi95egoYR+qEV1K+TK0zYnIL3tL6wXDuTqq?=
 =?us-ascii?Q?xu2XuELQjPPyVo302Yn0CVz1Q5CJ+yz8EoPZTSeEgmw7Y6ujD/8fjcl4XoWd?=
 =?us-ascii?Q?2A05eP1dqvVk6XRNe57jQmNKXM5uGah2jUlgF/Ol/dcHTRFNzSLiO08BbhUS?=
 =?us-ascii?Q?hrnCvE6t6KiYGYEEbKWhAW4PLgIKIZEHKpHIknDgCyhzNigY6l4NBREMNzNs?=
 =?us-ascii?Q?TjSJkxX3ySEOBeGOL9+a65Jy9qODT2exU/vu3kIwF+RzChSFGAcOrpkF8uUw?=
 =?us-ascii?Q?17GQo+Q8bOV3jd9Pwid6XbvDMCowbe7/ZgAOWDe1HLOEDU2xRSQhWCXNzFA1?=
 =?us-ascii?Q?0qa6XyYWHaZruunfGf+gvtm7ogzP3gPTnCdbKNRHC4Pw4S/BOxtIXA3jljJs?=
 =?us-ascii?Q?pYTt9uD2TbCNEVW2HPSD2XBdXWldE9f2a5pfgfY4qYGcJ5VlnkyZNHSgqXJn?=
 =?us-ascii?Q?M7h7Vi3FFdzmsHmNkxV2sFg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	756uo4HaYpZht6ZYUpSetKhBRVxiLa5onPqwk7Pfe9Ti3YK8th8RDfuU6eSgsfN10UBOX7BiBm1rI5O568tD3iJIglmmYsaLMo+HIkVRbEEgcGrP8WGu7priwr2TiPTO5T3HkCBklS76yWyar0iAsdspCGAhxwTcl5GYui9PfkuiW9i1iXmwfLWzmgSZay+koXgLOf2Lt9qQIv57mGWaCFiHILh2RYC+LbiX4TIK0HEonYr9tDvS9BM1r2Va9qeGXgrTygVTTbZMz4NzCP8mp1xCnkwLRpQ/5Tp2fqfNO8mou9MzoGIdWq2TzlEahuCwbc/Kz/0q+EYUSjiqV1F5U6KbJbhyq9SPx0hop09W9u4QSjuGIBG+RFPpmRlydSitYJyjphOEdG0+icKha2/Wrgq6I/dNws4toN7hVmobVWNWVvFAV32yGhtoIp3OsYGLqSkFbGx+QUzeXo8Dh6iwjvtBMKJNVR4aB2oTybIA+4yvykKGkQUqSaOlKJwcUm32zV/KhNSSRY/uMjrlVclZbkDsqgNBlDHfyESdL6bNp1HNSTcjR5B/RggGHvHy1hGC+1PCmL8bsSkNLCySq7APH7076OumAl3F+w7wyrUzNFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f964b6-c8d8-4deb-c4b4-08dc6dd79b16
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:19:56.9303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdgBD0AVCi/vNnxKl5cvrBrjNgpMiFeeU74Vah406QLhd6h1jwOLvCRFKwLRYL93kWfjJXiL0vDLT4pme2ihFtSKfq5NyRXJRwaxgqpb3so=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060099
X-Proofpoint-GUID: wya8-YmrBmFiIukCuzYO5S0kflule0hN
X-Proofpoint-ORIG-GUID: wya8-YmrBmFiIukCuzYO5S0kflule0hN

Added a test for bound computation in MUL when non constant
values are used and both registers have bounded ranges.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 7d570acf23ee..a0bb7fb40ea5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -927,6 +927,27 @@ __naked void non_const_or_src_dst(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("bounds check for non const mul regs")
+__success __log_level(2)
+__msg("5: (2f) r0 *= r6                      ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=3825,var_off=(0x0; 0xfff))")
+__naked void non_const_mul_regs(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 &= 0xff;					\
+	r0 &= 0x0f;					\
+	r0 *= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	__imm_addr(map_hash_8b),
+	__imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("bounds checks after 32-bit truncation. test 1")
 __success __failure_unpriv __msg_unpriv("R0 leaks addr")
-- 
2.39.2


