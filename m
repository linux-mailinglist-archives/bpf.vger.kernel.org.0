Return-Path: <bpf+bounces-37516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DD0956DE4
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3684D1F22401
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 14:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCFE1741EF;
	Mon, 19 Aug 2024 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AtS/erPo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dKx3QCyO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC044170A20
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079218; cv=fail; b=mkkl0w3B+35Aa+bdj7wJYGpv0GCD1mOYGBTWtr7C4Q2oHklSsQGy62sjcoKGQc7seeSdPzRvcE4gmqfeU6gOJQHU7LUZJ923hISD0EpwoLKKH36p+HMfMVTti+n/zgeLgiVOzm01hqOareqaTjkD2ha528EDJwMJTfkNmkeRYcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079218; c=relaxed/simple;
	bh=GTWa1hKf7k5UJLxW58olFcXgwQNBigF2HvpWl9ZD2tI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FB5PzUt6aQUuuDE5DuGM+aVgWQIG2ludkWfpqEOP0FRbvIy4TJzJQ01P0QES3ke9zFsyQvDCPSRZ8+WXa8jLbVA1YuFPJq0YIxh8MX+PY0wq7tdtWoSuPt/VPsOrXjGxHS6JpN3jLdpRihkhSoLC2nzgb1BKQV1HgqtgR2ICSRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AtS/erPo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dKx3QCyO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD6xLs019063;
	Mon, 19 Aug 2024 14:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=dAr6G6+qH7OZf6
	yq00niXLOhaRSRaiMX8QLUJxbWuKg=; b=AtS/erPo9UQupEYy9WX3AhpBLTSDW4
	LjIEMQOmERMDm4vIWlO4gFQlwpmpoNuDQKGuMwJ55oBTMKPvnFnvscGor9Wt56xI
	dovXGZv4wKtILoQM2llrKoMLvt0zDFQ0enesp4+f19jlad1DbOtLWSQakhcHngrR
	KdeUjikADgGdUqMU3AlFvIG89bm1bW6BAVR3zE2rcEB5y1HQr8Jy7m8UP7uSzRM7
	d9Cddb4hnGcvo5UkXa0IoyGKQY88sv8IelWNeIanxKOkDutW8MQGAcy/mffrz/OF
	FC7CG5b1skHwyldiP4OPVQMgvZhSeHr+dGOBb3m0vmZA3mHqoEV/EbXA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3hjsb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:53:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JEbIaK037794;
	Mon, 19 Aug 2024 14:53:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 413h5s6shs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:53:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWUmm05rsAQ8+gbWQ+Y4b7tO+j4i9x3QmrGvblb8cpYQ5XbwUTeRBcMYOAwQjQCwEFCNRHgA6oT3J6xdGnLeBSVI4ITJr9cvqdAeULazm+/P9yVzWPskvbGloa3XG9LlUHUc9xSqAkY8HGPf1ASyjDOXFPM2uVt39IdgWmLoajKdn71Fgnkd0TG8vQOuQjVi1fJVUKEGDAo26urMYeuNrAxjYXRE78PnpTYjvJQJrREaTooxXNimkR+6O4jNKYF2oNBnWAR88bqq+jnALrjA+CWX4zI2EAPdEeJcw1RRVAyXJVDt7p7yWFoDJhN+8CWFt/9BqfVZnwbRHbn5enpEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAr6G6+qH7OZf6yq00niXLOhaRSRaiMX8QLUJxbWuKg=;
 b=SRo54dJuQchOk28U4ddleZiu3gSc/ApZM+pOApBn5+coeEPKuvXj32oPXvsvRKbwZ3ukE4WN5yqRKiL1U+Bk1+kil9ajY9cjBrUQUUJslhYfJirpD9EuknVi+PdUb/h2WiDd448EPlrZp6+K7UdQhjn+0YJtNczneboODw46Vng8S6ehN6wMqfhbxbtEQyxgsxD2wGzLPDNwnIZznPU+UCMH5yxVaYe200eVYWOLbkIwIhPTUVNZ3MlWpnsDCkzdNQv36zatKvZ6Ene5WMsjCMC90aOA5BIGKqYzcNq5EXjakv3yao0yJR0KhHe0/ZhviCNUw/LkzYMGgVTLCEzEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAr6G6+qH7OZf6yq00niXLOhaRSRaiMX8QLUJxbWuKg=;
 b=dKx3QCyOh7i11X2cunXgNMg2LCKNTZ7Qsiv4ZD2tKN++Ahzk/gNkrD9QZfdK4DgsbOzFj8LpGPC5vsNO4IzYZ5LiajCwxIDAxBvgIFGkwQAmbqExjE3UOTye8Bd/OOOyg8irfHnPuARvAiRA0TcKZQl5oXURUdB7U8kgRxU+nZ8=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SJ0PR10MB5630.namprd10.prod.outlook.com (2603:10b6:a03:3d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 14:53:14 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%2]) with mapi id 15.20.7875.016; Mon, 19 Aug 2024
 14:53:13 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>
Subject: [PATCH 1/3] selftests/bpf: Disable strict aliasing for verifier_nocsr.c
Date: Mon, 19 Aug 2024 15:53:05 +0100
Message-Id: <20240819145307.1366227-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SJ0PR10MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 29132785-fb76-423f-468b-08dcc05ea664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U2C91QLGT4Tq2aqAGFpY+oG3n0GMNFdsyVThD6wvQAPf90PUcjKUHahofT1Z?=
 =?us-ascii?Q?InJG4zpHxcjvxmBjThe/8YNzwZpymmZnvtbSUQE3CKLM3AYBR6JYKPwXJu9i?=
 =?us-ascii?Q?UMDzGBLmxGjRZBQYYz6IPDI4WuPF0j84blMVwzFfAKTFpj2KE53iV6CTT7ia?=
 =?us-ascii?Q?bgX3j9edW2GeLoGtiEMUXICkdrUmz8FjN3Vlaa+mkEVFvs28qJybt5MLA67A?=
 =?us-ascii?Q?sY6pxWebAQUuO7vTrF6gTRYJfNoJRN8HdTReBKzp3J61zdWwep6TDff+5nwF?=
 =?us-ascii?Q?lZeFzSQu8V8ZfEpLZ10hqnd9MDQsP3U2YanXBH5LdA+DvredvULG9f7uPpEQ?=
 =?us-ascii?Q?W4SmlwqFjeTgjO5LsEjQ6/V9asdokJbzTLN4CXEcGovCyOhz7enM9gRbfKRD?=
 =?us-ascii?Q?tqCAkk1z2pWFM3LIidaY4ssNS6NjewiRLZ0JQ/ONOXvOr8IFdw09W5nvQy4R?=
 =?us-ascii?Q?lrNFp91uTJk7AJ3xEVReyJk76nEAXENdCxMs1LWm2S9BZMcbDWa3faTJ4uz6?=
 =?us-ascii?Q?nrtTP42lIZ0FmZH48i3DyOIF80j4ELQAS2mLkp40PaX5cChShWJddVE8HpBg?=
 =?us-ascii?Q?spmPxHB0SUKHGwsxixeDmj29cYjH+v6mVrkqOog7Lqecm5ggYUJOSi+m2Mui?=
 =?us-ascii?Q?CwRYzgq5ZnEd2rmxJ0X+2hv1AapMWGxZfmZ6aGe4uq8yayNmU4azpwe6e1uE?=
 =?us-ascii?Q?FK4q92b58fkcQ07HvErqR3BsBHH6Z4Va3Gd4jxrmN0LapmumoiSs579YZv3Y?=
 =?us-ascii?Q?bls2ZI7Z50F558Um1/hlYNQSq2Fhjm4It86lbtGf3Mav6Win48Pen2YUSS0O?=
 =?us-ascii?Q?ue2UL/kU8p24xNckkITfSvp1yfsxuLQvT+liCdsjinkD5SreJ4uAH2AwoAOe?=
 =?us-ascii?Q?zh7EAkrR8rm0ffLNvL+AZaEs5HUFOrpYu6X2malgOW4OXaQIqE/gH5+p9j1d?=
 =?us-ascii?Q?IYRDxDTFfORDqx0hARVjxuGM9Jz7dYCSeF2m91pNCt6PY/mLBuyiDw7fT2P6?=
 =?us-ascii?Q?88kuCnXo6hJmnvbEaPI/VBSV+aluKXwbinVlVw83eF84/n0vqn5ZHUhqmwFb?=
 =?us-ascii?Q?HzZKXbBYT/9o0E7PwHgQzYzUQvCf2A1IgJHZqsB3FgotcSK+do6lF1hUvUI9?=
 =?us-ascii?Q?BvOqvd0qJNFII/d6bFMwSRKRaCdgjiab99t2vCWYnJRRnWLcuUtp2GnlCv98?=
 =?us-ascii?Q?WQChh23Xpqh+fvfOf0Onqso/SrfpvxwJIi1hgw52CSqcjoxcFQOD4aB4Kn60?=
 =?us-ascii?Q?wmnB0e7cXmg5L1zWb9vqd/sog3o+/20oiFw3d/kCqASkLkFSZLcXhR+DFNMT?=
 =?us-ascii?Q?T7tO9Do/UpKLxHpo7u6rhA5B2pE6Fgu/93SJJVui3sXnww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L4y/GVi1hMzqgoS3vtPwtvmbjHA08zDD5bftI8isjAXuL++C0xbQI8f1lliB?=
 =?us-ascii?Q?r1Ce6RcH7Ide3HQM9YqqoWQnh388OGKE0nuWZIzIBxCHc8yAxykY+L2PXGNF?=
 =?us-ascii?Q?ITR2nOqyz1IR1b0IFlM74xaE73tBsKHWFefeQDtskmmMctTsu2HIFBzJe2O8?=
 =?us-ascii?Q?/cw3uhlZZcEjanPm8E4R1sWAa1YQMMvs1GD1kHVKQMdZAbs2+7Ge8lrYidOO?=
 =?us-ascii?Q?z2IXp8VqDvN3xYgonPR5gOhFx270sl13FuoYhukfLQpiqKAQIe60YndrLF3y?=
 =?us-ascii?Q?zSlEB6ArIPCNZ0qaaOslfuD4Yft2XULV8BgSPhlAxFTq6le1GK7nxN3sx9xt?=
 =?us-ascii?Q?EcmmOXX+75J4ZyHisSA4AkdyKAN/OzgTEcySjPH3p1qTR+WdR46HqFo+GSBM?=
 =?us-ascii?Q?2LQ1Qbwnzi7C5jALombdN9Uzs0Ics1YHlONYSo5CI5GILUVBATSffRC+I5YU?=
 =?us-ascii?Q?B2HfPrC2p8va92FfVvxOmXTx0cLS6eAkTwxRQ8zxklS24hvKV3qGHNrU7d5h?=
 =?us-ascii?Q?ZFhQugJlQU30iyMVzJo2vQpNN0492XHD9BpMJSzWUTCad4Pws+DnPMDq3nXW?=
 =?us-ascii?Q?p8uga2N1cZpanKUh4MCw2Tgq7FCJlp80vGLRs6exxmSYNh3/UOwLZtFM3/0S?=
 =?us-ascii?Q?XKmRKLijbuF/+ipDUfe9H8pnO6yKm7Tv9E2BPXwDqXgtFEiq5mKFI51hiIXR?=
 =?us-ascii?Q?mGHTK6ZHvTTzCqroSW9HVbtLaUutxmkyyhiPBHuOlMhyNQonpchJongccotx?=
 =?us-ascii?Q?vbkzo663xQRjEIOGzURhf98iZ/khOzqV74kZ7hLC2jfXu7h9wpmVfej0OJbu?=
 =?us-ascii?Q?ygcYacFSq039D2ObedJc/XV85d3qaE6G1MzHJFrGTIEkQtPOBPvTGD/blAa+?=
 =?us-ascii?Q?n10NIQGTNR8HNmkQVNE9W2bi5hKni9pMxvlx5NgQTIzWeoPKqQhOHy/vydIY?=
 =?us-ascii?Q?Ed4RnfN/Uxl020HaJshnSe6XMLJ/791ZuiOTevgNB9kYYuhvQk0Pce14Jd5Y?=
 =?us-ascii?Q?DL4W5U6o8zemGW0/t5X3JrOhcOJts/UUzXM3wGH84RHt0Kpi2EQiBLqAzz5E?=
 =?us-ascii?Q?eZImGmouO9dmyUk0rtU0ad9/dJFlUxkeYDQtYQhoIaYa912EntA/3Tc4RFmL?=
 =?us-ascii?Q?/ZDJGV4COgF2ZEKRTfqNkkOMeNGjpwhymL2fhTRZgs+Na38dklfG57R7cZHb?=
 =?us-ascii?Q?oSnvjrEn4Yv05UEVev5PIqGRC+YPU/47GcyYQ4xZ3xmTJWjFGt4Fz1F5LqNu?=
 =?us-ascii?Q?GKwdEekyVmLbVT/hl6hvEKpyK6vc3bQC9HYiIHe3pa6ZDwwNO1R9IIR5yLYF?=
 =?us-ascii?Q?ofdTBpBMP9bEsAfSGcIfX2rKur7gE5ATBRhWd7K6sqxee3d/6+rBXhaNbwuK?=
 =?us-ascii?Q?edguCLdTgUTpCGkV5rrbv7PJkf5MlD4ImgzkaVZy4erVC0d2yAgMUPUSwiIw?=
 =?us-ascii?Q?vmarBv/YDmzbipzMMWy6iB+7WbfPnRND9ZhhsPDGhcp/SVIMi1nvjYbUt3Av?=
 =?us-ascii?Q?GmBy68vxbf9BgKviVmpUThvW9eNqCnuhc9rJ3IQ1P62iZRftv+9gg9pTklR5?=
 =?us-ascii?Q?EeGW5AnYzSw/Mpz03oI838CLGN7Va3q+7ZGfVic30slqg5X23mCFibaSgS53?=
 =?us-ascii?Q?ImTZwDH6cu1Z+WLK5PcclPc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+N3kuTBNIlzLRwC/qM1ARP6+TsuXuSSCo2Ma9ljcUkiEHaCg4L7/fOUQalSzzPvHrVFAfhV1X4bGuZAinv2ve+X9+27adkHYK7yGlKXhjPXqaaPBah/DSmuLBEaVuhIFndnL0z4vuNOpfzwg151OhlgkeliRlFl6+Io5/2hlcepIphgc/QU3tXeGQaGTh+5DbYYI32MhjGlLUDznK2S3NEQnnZqWiRC6oSAToy4HTNpy8kw0LUIlnWNXp2M/lwYPVwjBjkcbXqPjlYGZDB1oaGhKxSIWbQjzDi5xVSC0xCJGMe4XWDpaVb1PRf1SZ7N0clkx5nseM0nshNAQWLZ3ctpm3e9t3xrgoC2n+ntavxZC1pZKYBEMuRxduIud4COZ10sNxmFaZ5m4Vsz0xmc6cCZroB65ccoUJZNuFUOynGJVbekikHQH9LIQQycqIxTlCEM2JEyEBlY21Ks+Fw2oU9YzClJLUzy7hsrw+8NYTYyg+k5jAiBbZG6Oub/ng/bXYWY0JA92T5fv1OyjP7xqFSG/S0udgc+lJdyeaSZnYJ1/8F0+1RWtCzMZb3kDeonRDtGG8n1zGZPBOjSK4E5khQi1W5QdyWJkzZhVuixO8ms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29132785-fb76-423f-468b-08dcc05ea664
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:53:13.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sx/69v7vEtjSin/HD9tsxulgoOdizM75aczO+kYzkUJ06BiKv3owFhmSSlt4e5ZYMmQYMJlm8KdZiRWR2+SKT+mWIT3bBBt06T0xiztrW7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408190099
X-Proofpoint-ORIG-GUID: 2fGs-nnZo-kuaplVBokJBFUEL3VFHYMu
X-Proofpoint-GUID: 2fGs-nnZo-kuaplVBokJBFUEL3VFHYMu

verfifier_nocsr.c fails to compile in GCC. The reason behind it was
initially explained in commit 27a90b14b93d3b2e1efd10764e456af7e2a42991.

"A few BPF selftests perform type punning and they may break strict
aliasing rules, which are exploited by both GCC and clang by default
while optimizing.  This can lead to broken compiled programs."

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: David Faust <david.faust@oracle.com>
---
 tools/testing/selftests/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 00bde031a469..ded6e22b3076 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -58,6 +58,7 @@ progs/test_pkt_md_access.c-CFLAGS := -fno-strict-aliasing
 progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
 progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
 progs/test_global_func9.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_nocsr.c-CFLAGS := -fno-strict-aliasing
 
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
-- 
2.30.2


