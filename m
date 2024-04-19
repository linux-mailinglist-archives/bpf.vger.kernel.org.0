Return-Path: <bpf+bounces-27213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D778AABBB
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 11:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA4B1F21F98
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 09:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1857C081;
	Fri, 19 Apr 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C61nmzaK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0EkSWdCJ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8371651B6
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520108; cv=fail; b=jYAjvCZI9G8XBvUH5+H+l645T9kEc5xLitfmQ0HnWMFLeHvVA1ROg5J7n8qE0TTsOGPOoLnBbjXxkyaCB5MTkYg8ZCrtO9xtnlmvb9izTSRppQse25MKJE/7TkyVuVqPLDP7Xg5nOgQ0A1upwVJ7yPQIx+GTr4Uxf+rEpqNMiwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520108; c=relaxed/simple;
	bh=uDcFucVxyUfGZiM+kYrLZ46Of2cL3jbnH4VB0AZh6VA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=n2Od3wLXv2rVmyoQ53dNDGz0mMws4hBHOwEPkPmgZRKhjnHLhdgYuwW3dVrExqEgmyOcK8CEyx5yAymGbcklKJaBHDd0VocVHtLhZ7LP4gzuujjVe2OnbK8XCE32H8PWxv4VX+ZLrShovVeyf+BNnj198ZewgVcTlHVYzmAgErM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C61nmzaK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0EkSWdCJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43J8x71d004087;
	Fri, 19 Apr 2024 09:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=7qF7Em3p6hfPq+LMFvbKk5ZuI6ETfwULKXF+TUom0PU=;
 b=C61nmzaK3+aHVlU03A8LLjKoU3Aik22BodVVrHoRdkEHfHR3Y4Pm86en7TAJm1bed4/4
 gcVHZLm3QkuimIcxJXUVLE14AkTQUSSWDK7KOM8p3/QFzMAMmaS+29dwGPzxuK+l1u0n
 oI59EZayA4t9S4Y3Y+f1tJ6Nz1Bv1vVjK28ITrF69N+fw5nt5C3TZPpinUbzO2WF4iUw
 bSE8+efZ0wlU/FEFxdZspwQd1kYVUouex296KRoaRCdqXhLpqK+CdkR/w8kygEzYWUm5
 a4FqPwiIhCUjWM8rx5q9EJxku44Dfp3oqtLlsqHWIEo6YewJ6uWllc7R/i19LkpSLMrE YQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgffmetr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 09:48:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43J9VAWT040137;
	Fri, 19 Apr 2024 09:48:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xkc5fttx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 09:48:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QX18MJOLpMzRKm0nipqWQvsFr0Bn9rIrzRKSeGlZOBHTrUsA3RFiIaMyg6hJsPjoFSt3AAsrae5dnGOa0zDxxfB8WS5DPaWRWCQgyBKNXWl8YluIxogwcZt1Zm0YOXFYRY0+W/ZuVMWuhbZP/wS1N/AOg8bDg0eZwqEeWei4Zz5cPqTPipt+l6cC9xb25ewXy+c+esyAaIOGOCruU4Sgcdx7ta9ksss5JSJyl8Ryp70vl/CYFIxBtRNpzag4TI1wmTwp9UC3b38nEa3XSWiFKJy6+dJwssN5kwdSUvvPPQkTKe5FlpCtZG+WTgpbWbMkPk0oVcvWdrrsyYb9cTD1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qF7Em3p6hfPq+LMFvbKk5ZuI6ETfwULKXF+TUom0PU=;
 b=BAH1Z9t1FRDEXu38aVtkZNiMOJwHJS0AUyTkMF+zIJChrW6UiRvFY372uW0IelMH4MwyG6oAXzilmTU+NxYuRh1eNIVH/eRBhm5udbzAg2qvhnJpbTLzU1x4buT5aLd/09g3aNp19g70x3R2BtHE1O7bThBDvCWVKfM9vVluE+k/LQp/4e1kJiVDPtHVpsXq7/bvkAi883GIl3qadnVcYiKahoGeJgNRF2+Iz9w/jl7yfaG7R5Iuj84j7ZNmxAgfAyYtgGymhiwIR9uaseniDxPq57FXsT/H2P1VdRsqbTzWZMyw26KvbP/v/dfDk6yK+Z510MAfd2TdJXHVaI076A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qF7Em3p6hfPq+LMFvbKk5ZuI6ETfwULKXF+TUom0PU=;
 b=0EkSWdCJqkDNJd74dwOIdEHg2u12fseCjcqaHTb6KDYKCpfki9yCw1RLksp75nYZwyfE1Vau6s4llsOskLPOUUl8RjKrRnkObVLLkkXshPnJqHuTvNPNoEgwrc6sBwHbWO80Ht/Idz0fRzXRB5BSLnC/gI81VgE54a2C8ex8ZTo=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS0PR10MB7454.namprd10.prod.outlook.com (2603:10b6:8:163::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Fri, 19 Apr
 2024 09:48:00 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 09:47:59 +0000
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
 <20240417122341.331524-5-cupertino.miranda@oracle.com>
 <78488c062d4154f78706d371bf3ed600a0601ab6.camel@gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
        Alexei
 Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust
 <david.faust@oracle.com>,
        "Elena
 Zannoni" <elena.zannoni@oracle.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpf/verifier: relax MUL range
 computation check
In-reply-to: <78488c062d4154f78706d371bf3ed600a0601ab6.camel@gmail.com>
Date: Fri, 19 Apr 2024 10:47:53 +0100
Message-ID: <8734rhk7jq.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS0PR10MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f73f8c3-75d1-4872-bc21-08dc6055cc65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NfGNjR3c6mh3TfzIfsF/Aw12hsZkIefyqoOgrP9vHqiaVMWdvlBCxroDCNBx?=
 =?us-ascii?Q?DUEopD04UAOuvEyWtldZQ2lqLvFxMLHS7x5uCOZpVMR/575y8y0eqEArHqHJ?=
 =?us-ascii?Q?/+Npp8vjHCESWFqLfsXnSMXXCZh7LkVohx6HXsut9Q1Y3/JRAptlgi4ZRsE1?=
 =?us-ascii?Q?eTcNiR87i2t1iHUAnH+u5373b+L79Kwdt+lpysH+FLKzN/DJHzO7A2jry5pw?=
 =?us-ascii?Q?6HdFo8pFGKY7jUbU4yzr0RDbv4F+aWJ3aPKp4pT2x/GQegQw6KQqbVVClQqz?=
 =?us-ascii?Q?oeKN1gcAAx8rZpeUg1qX+pFyYeZPlFcYMaR2wwEtw6b0+C2g4Ih9j9Q8uASA?=
 =?us-ascii?Q?n11bS13fz6P34Hij6haKmn1Zs94pB3M6G1iXfGkCtiqt6MnbB9aXghwb6CIr?=
 =?us-ascii?Q?JoL8bHTE85gMOEAm0L1FnlCGvoUpnnP1vjJJ3ccJWKoBrwhDeGd+lq4HuK7/?=
 =?us-ascii?Q?asES4nXyD3PRsxUMneC5ZaUWMZ6m1esHMsfXvpLTdrMDfnH2eJMgimtLwtcg?=
 =?us-ascii?Q?D21KGhzUhZRYGTd4gZyO7Gxvk77vckpJA5nADygt9/cqTCaMKDCB3q66U5Nb?=
 =?us-ascii?Q?wgOzNdf6YH4VWqahBuVGggJp6UAKfp7PWrb5HSD1RDi4RV6saQCz4EO9+tad?=
 =?us-ascii?Q?u2C7vbYOi7xblYpK9/VX/a3N9w/Gin2EEltuotOGnNh0dqFCm7jxR+ijdQri?=
 =?us-ascii?Q?lQBS34Xm3w9VX/nAoP6F2mjdA47aFQc3nBp9iH4DwDd4XH4RymTRC4vBhmUu?=
 =?us-ascii?Q?4OYRkwMILObU1/DQjrFImlQEArhtcA8nxpaRk0NKOI+jOcf+YkCChRSuo6cI?=
 =?us-ascii?Q?PL4UgNoze70IORjYIgzENTlwnZEhg0OPndW9yQ+InmrTF9CGxWCAwrRbbb0q?=
 =?us-ascii?Q?YufXubsIznkgNLvFZhC1GwtHoSny93LXYKsgSQSwVfK8o4vxnE0IHaF5MFHL?=
 =?us-ascii?Q?E6DVFp6GRfaTSjz0M0/mVgilBgxV/HvHdOczRrhw5H6PpMJtSh2DBuik2lMu?=
 =?us-ascii?Q?W3c1ZU/2VEsrZOKBYbCwtDidfhLBd6cMpEn7R2WgDFqtUyrC30GrtAGAhSG6?=
 =?us-ascii?Q?UdkgNltxZZTE2b2QwkMGGVU03U00Btuw2epvwStiZeZKfOOXpGWp2rBvLumL?=
 =?us-ascii?Q?Azxn7vynL4I8OLmps7KIY9IFaEOx0tB5rd8lLUdTZJ6WD4lqoSIelwVtYGX7?=
 =?us-ascii?Q?U2nRfQ/unfcjXQaG1EXud6BgSnAymYk/CfnzYZIs/GS+osyvUJRdNahXxITq?=
 =?us-ascii?Q?UiNoeOHV9VubTYglf91LWyb6XRPThz9BEFIl2wWZ6g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IpiM/sQxWF02QvUSqEs7iyeaQbE8fmDtHXdLPQsxL1VbUsodkRNpLszF3cLj?=
 =?us-ascii?Q?VJOEUsaV8JI8nKpICdn/XZxUuvc1ZHy7lR7x5FbBPaZhy5dLwX3iW9oTuHyR?=
 =?us-ascii?Q?WixILIN90Adb/K2kiRG0dT2tk1PVxDaWhfIMtzCxTv0x5Di0tp8vsYIWKx66?=
 =?us-ascii?Q?lxk9mcTonDeB2keSik8O7YG1H5UOVZWHwcUMfcuj+6H7qtuYdXqUjhkzGBQb?=
 =?us-ascii?Q?NdZswBVkLICVLAP9fZWf6kUI+CPWlP9nC6QWlb9U3mIvF7utjpHHeQNVsOtI?=
 =?us-ascii?Q?QRPj9zy8xomNi1dJZfW0DY98b9CUKD8x+RvVYKQhrUwuCdxwtXhHhrbpruA1?=
 =?us-ascii?Q?W6BK/hxrWYbJKjcb2XHQdalp+B+SNikg85JNc83aXTvNgHo9Cz5X1OHBltFN?=
 =?us-ascii?Q?sfSfnlOJKPUfyPjk3xI1kqPTUgn/4WKT3Qnf6u7T+dHnaO3gMRpGpACE4s5U?=
 =?us-ascii?Q?uFgIw2vjXGq3FoJMb5ErmJyAvFvefIoYtPk7HglIeibyikSgCTg5CJSEXwXK?=
 =?us-ascii?Q?ybhC1pz8NspVrlHr3tYPGjQg2UJiN+bWUZahbDlIsmwUVEp+yVVlMDxbbAno?=
 =?us-ascii?Q?bwnFp73G/pNt6vhvWxTT3TBbWz2lVOD0+NqIBbMTz6JkEt9a89w31iNCMJdN?=
 =?us-ascii?Q?iyRVyIBJ/h7/4H+PFWBQymXOzURIhiNbqzVDc3OXhyym+E6yPupENLeOleg8?=
 =?us-ascii?Q?IBy9tEfp4wtB32zcbHV9pwkl8+8foerVJcagwvgbfUrlQGD0KfxJBSqXpe26?=
 =?us-ascii?Q?FB38wYhBv1qC6TXcDE64E10ULtRlRP+iy3qFD5uOMOBpChMgkIWqN8ABDs4A?=
 =?us-ascii?Q?SH4V8V4l+vU2Bo9OAEFK4QdV+C8G+1A4L+lSs+DAFPUme2DcQsaEp9y07y2C?=
 =?us-ascii?Q?sfSG+fZmaiy9xUV5LU0axV/vVgZZZtr1FQqv8QLcbHCC7avsbmvVltLDrivY?=
 =?us-ascii?Q?FvSyZaScYdmOYy4CYXQwJqcVrudoatEzqOijJQ+BCbmhBd8gg3iWkqGUn3ro?=
 =?us-ascii?Q?0I+gkOlfXILLogGyQ7f3mPhkVYVwdPQbkU0o1r1TYaU+g/mZp7hj9QliW58T?=
 =?us-ascii?Q?KdXWBaZydQduBxtP/xmdtY182gGzHuwuwiLfk1GrtYL7vKtM2/ttcmsI/Ry+?=
 =?us-ascii?Q?V44t3lBAWvG1devnWrkz5sXkzTMNC1M+wb7hKpOYhMu+hd7lm3BrSzOjFKYZ?=
 =?us-ascii?Q?NeiYS1oVblKhWIUsjfZ6IUUUGH1aamUKSDrsIHna5ainR1WjygyAEACgqTVS?=
 =?us-ascii?Q?/lClc0YHWzz3bJnDshMcEc40tJs8nkT5W10eUIiP09Licj9vt//5QzFNdlzt?=
 =?us-ascii?Q?48lBFmLTQB6nUs1pgm90Ho1c3xprg51zLqOSYRaUHfEt1I2tb176RocXXYnI?=
 =?us-ascii?Q?t18IOkoq3Bn1B2VupkkP90MQwQO48f5U0gmqJwbhUs7FERfHPvdhIrebiBQW?=
 =?us-ascii?Q?I+mFFGJIC0XssM6X8ayej/7qEfJo/dZJ2eaAaSFy4JE9oMVA5xmqYhqdkvUB?=
 =?us-ascii?Q?DQ7t4UZrIs0WOs90nSc+kD+HU7ozF2pJBqNvNjB8uWAr+lrlPDNcoxvSt9El?=
 =?us-ascii?Q?nRV7Senrm689sGoKKO8FEwv0OOP4PckRTTuo5rq2fZK002iQf+SBB0NXuGWP?=
 =?us-ascii?Q?zsHUnQa7+JbUGtCxOjEBj2I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4Rxt8QUVY09rFVA/6ibLwZn8cPaMKNlI5/m1tYFRCycORlNoVJVdDXeW6RqbQbF5OFvDJcJ0pNF85mZSH9RncaDhV/kpzc2pyO4Gjz0KUeL3kvLCgGYQ/q38Jy3u1/7rOgAjb8g4Evzu9m2BuWg3LYv9/0XdTmIr8sDdMGlL9/TAwW/qL6xvBtswoFoiteDqt03L9BEAOqu033uK6kU64ecERQdv7EpvbMfQuI6nJ0DMn+IK0GLjZlpNG4EMadrR3v+WPxJm3DiqVzPBlLRqdpfFSdpj+Cvz++dTUtKUzyAC7uxHwc/pkLMzzR5wcgc/5RXyqoIrDY+WEVu+Xj4xUJra/wc1wObprwD1p4Ly+Bf6tWu6Iuslbx5j/Chk+/hRrrj1AKH56nb46mZHspvRH/j0O++jhB44vcR63kmjUfYBB0EE/QHB6Kady6Po2Cxv5/Wy+xU4M4gG4m2DXTGIl8B9Zk06EUv1M6JA+++99qOspkhfSahgK61EJNeFz9TjLTyV1XCyMLsC+DQ49O991YIMeohUj9cXP5bO021p92s+4KveYUxox0AvGky924Jv2Sw21XVa8Wm/1GXkxTm7npnxv8J+YxE3HhC46qLHsf8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f73f8c3-75d1-4872-bc21-08dc6055cc65
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 09:47:59.9284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LucyyhyZQVhrW7RdjRf0hIKuWlk9OhNohfwdghAxF4BNY+ELz2N8JV6T5dBQgrfkicAc2p5CPb5kZlAw1TIrLvj0kkkMkB+0Hxq1FPPQNx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_07,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190073
X-Proofpoint-ORIG-GUID: _TmlfYItjwVFdzyX-JtnuAt52hFxFsm9
X-Proofpoint-GUID: _TmlfYItjwVFdzyX-JtnuAt52hFxFsm9


Eduard Zingerman writes:

> On Wed, 2024-04-17 at 13:23 +0100, Cupertino Miranda wrote:
>
> [...]
>
>>  static int is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
>> +					    struct bpf_reg_state dst_reg,
>>  					    struct bpf_reg_state src_reg)
>
> Nit: there is no need to pass {dst,src}_reg by value,
>      struct bpf_reg_state is 120 bytes in size
>     (but maybe compiler handles this).
>
>>  {
>> -	bool src_known;
>> +	bool src_known, dst_known;
>>  	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
>>  	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
>>  	u8 opcode = BPF_OP(insn->code);
>>
>> -	bool valid_known = true;
>> -	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known);
>> +	bool valid_known_src = true;
>> +	bool valid_known_dst = true;
>> +	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known_src);
>> +	dst_known = is_const_reg_and_valid(dst_reg, alu32, &valid_known_dst);
>>
>>  	/* Taint dst register if offset had invalid bounds
>>  	 * derived from e.g. dead branches.
>>  	 */
>> -	if (valid_known == false)
>> +	if (valid_known_src == false)
>>  		return UNCOMPUTABLE_RANGE;
>>
>>  	switch (opcode) {
>> @@ -13457,10 +13460,12 @@ static int is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
>>  	case BPF_OR:
>>  		return COMPUTABLE_RANGE;
>>
>> -	/* Compute range for the following only if the src_reg is known.
>> +	/* Compute range for MUL if at least one of its registers is known.
>>  	 */
>>  	case BPF_MUL:
>> -		return src_known ? COMPUTABLE_RANGE : UNCOMPUTABLE_RANGE;
>> +		if (src_known || (dst_known && valid_known_dst))
>> +			return COMPUTABLE_RANGE;
>> +		break;
>
> Is it even necessary to restrict src or dst to be known?
> adjust_scalar_min_max_vals() logic for multiplication looks as follows:
>
> 	case BPF_MUL:
> 		dst_reg->var_off = tnum_mul(dst_reg->var_off, src_reg.var_off);
> 		scalar32_min_max_mul(dst_reg, &src_reg);
> 		scalar_min_max_mul(dst_reg, &src_reg);
> 		break;
>
> Where tnum_mul() refers to a paper, and that paper does not restrict
> abstract multiplication algorithm to constant values on either side.
> The scalar_min_max_mul() and scalar32_min_max_mul() are similar:
> - if both src and dst are positive
> - if overflow is not possible
> - adjust dst->min *= src->min
> - adjust dst->max *= src->max
>
> I think this should work just fine if neither of src or dst is a known constant.
> What do you think?
>
With the refactor this looked like an armless change. Indeed if we agree
that the algorithm covers all scenarios, then why not.
I did not study the paper or the scalar_min_max_mul function nearly
enough to know for sure.
>
> [...]

