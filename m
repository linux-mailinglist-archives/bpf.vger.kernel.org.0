Return-Path: <bpf+bounces-28810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E18BE1FB
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6E51C20D16
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 12:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B37B15B120;
	Tue,  7 May 2024 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g4HPx8yD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zz/pOB/+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B87E15B122
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084564; cv=fail; b=V7N9ypzszoRxBn9DhV9rIqCR55Oi9ROO/gFPr+uA8I4ZalI5G0zpDjAZJ1MGm9sZivTv5YnlrA7cDrkcDC3BaFbDzHnyJRJ+oVsyarIm8idDxM6e03/+mW1IzL33CxXYEoY3VrdzQoNYqNcdJ611IHd43x0shb8ViN+fdeCJclg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084564; c=relaxed/simple;
	bh=mE0sKmbacFLSwWGVisIvKEcN1MjsEgCZVfE3tsKJaMA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XrhWpQSetfoRZvzUFYXL+WHi/wqPfi1Sx/9qcatiQJkvBCTJpkm5m0f6LGFeG9Vv9IYim4OQ5Gic0ihKzn81KJhOi+qJA5WQXbjkYdxzmEHF/VFVg3B3XwOA5YSydmseRMoODxy0k4uoaOVMg32/8UGQV52t3h3yuHA36DuqwnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g4HPx8yD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zz/pOB/+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447948LI011105;
	Tue, 7 May 2024 12:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=phyEQyRbCtN83Md30bdXyL+7m1HzH7TD80ZSBTyLXyQ=;
 b=g4HPx8yD062Gjb7wjS9aiw+q4ckWs064NnpHqHahywan33cNbVFCVen4Ert0k6VLlXs0
 YTOAmP0DBNlavLwXX65CBXbNZMnL807790Y+fDcNZMUiHQHwloFLo6o2SVwM6PSAv1+R
 JBj/qbN8h2iSJNbrUyo/EpdLeM4p0s0g80S3+j2NHefeEQRPGfaMZoxhzODMqWpBVijN
 M0WYAiBlq1mxZISuxITDbCh6Nba0DxFTf3R3zsHu215QimYLlboZRtbAo8o+VVIlL9fj
 8bDAhsJZHhsjXUZC0Llh36h2SgFcaWWgK92RchA4z55BXu6PIK9jX0+ikUiEaUllI4O9 0A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwd2dvtba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 12:22:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447BavRL014161;
	Tue, 7 May 2024 12:22:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf7c664-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 12:22:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi4b+b1gpXQHLuz0paKNmW8hhXaK0riSGOBJWOtC5dpnx9SxaoWyXbfZl4VQVHalAtFZCyq1J/r3s11bJC/e+1rrS05KO/ETwoNcJcN0XAxdDAUDdcU9PGO8Iyt0ytBqrEWSJfaYfoO97NkEKpra4iyoWV1E7m2XOf5fHVJC779J1LoJ19mNQ3uWE+0oV0qqi7TGNe91UJ/XTnodAvbYXNNEvzfJ77fHgMfz+NrFE0kFE7Ih3CBU1zUk17PgtEMRiaEOqTGMRUdtJoD0tZ73oNVLahhEcpYDD93n0Cqbyd1QcygdMuZCtGYzKLkw/ioMaXWc2WyPwwG3p769nCNoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phyEQyRbCtN83Md30bdXyL+7m1HzH7TD80ZSBTyLXyQ=;
 b=lAGJSHQXUs77dtSnt9MwQbawy9kfdkpyTRZs9aIeAX+TuwZDGO4cgEl5fegaJBE6wd6DKxyk0gSShaPRPmhTVew+0KSPBHhlv7c8oGy1hhyEIEJcuIyECMGQW6R1elrD3uPFwHmF1O8rt2hnOnjlzTdTqir2u+uIo3DBYw+BpT9Sm/CPQtMgLThTzhTC48n04JFe0HO2JUojB15eo7SteW29HSFADtTIx6z4tlN5p2XwwUJbTkC+N/ypjyfwuTwGv78lIjoXwyGsNarjT75+VIKiZqS4B20QvE366Rl7N+V/MsElIWUiZZxILlhuylwP/Zivng3myQOGcJcyNFskaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phyEQyRbCtN83Md30bdXyL+7m1HzH7TD80ZSBTyLXyQ=;
 b=zz/pOB/+PAAINPQzi12VeCMuFnotdGFfHBEhpWykRH02RuYYNg/MoN5ySjwjnasy2k6OCwFQRcWYKGwlSKbH22VCgLiQD37gd74OOID9yaLd8ZL7oiVsFLQ0K/IpuonuHE2h7L/rhF9C7l7zKPl9kMnNvKArIGANx8eITTDrkXY=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by BN0PR10MB5079.namprd10.prod.outlook.com (2603:10b6:408:128::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 12:22:36 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 12:22:35 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v2 0/2] Fix number of arguments in test
Date: Tue,  7 May 2024 13:22:18 +0100
Message-Id: <20240507122220.207820-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0167.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::10) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|BN0PR10MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b87d484-0496-4cfb-5ecc-08dc6e9060b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WuaKFnVjsVRo2xq2kzzgOdnJuHheXFvc2qdIUiIxKciFIuT63teF/0Dvd8SV?=
 =?us-ascii?Q?mBhPCjbirWFPMhrIJRzTEz98lL8uSsy4mO6RE0RniuOLxzhWgK4Zm5Cx8CoF?=
 =?us-ascii?Q?u8Mvj7qbMl8jqvijMTQhvMIJ+YGA++uYGp38YOc6jDvFcNTCRovHWCW5pk/T?=
 =?us-ascii?Q?hUjoSuaYzeZyQIVgWkgq/ZrJvOu5AeAIBSjLbxy3I/Ki2KdkVHVqH+FOvkIw?=
 =?us-ascii?Q?l8oaHZrekmtLQiaIvvTLBw7xUwrj9YLqgAuJlkxbIWX+yW/sX15t/L65UEp+?=
 =?us-ascii?Q?aaL4kX7WshR9DH61ysZaA0HJYsQnMq7WyQ+WEE+id1MyUuqW9Pshv5vuCtyO?=
 =?us-ascii?Q?Ik3FkgOo8z28DUfs3S35/cTtHIixTNnRtm0RoVTMCYpeKQpurqQNlabITxKX?=
 =?us-ascii?Q?mopxWKmJABsRjwHGDwLOVFHNc31lfVp89dprAmjUEar+EqUBtTUCZTFZ6wpf?=
 =?us-ascii?Q?HCSEctGn5FWCODjUpVLyNZPdR7wPbL5H1easy4WrFd/tCnoCQ3bOs0BmUZ00?=
 =?us-ascii?Q?gQgqKN/ARd6K74xZVpnPh4AizCZOOAvwwDPATByC16qT9gdlKju5pIorUvpF?=
 =?us-ascii?Q?IUJVCamZHtSw4e3B+znsK2GDZLf2FohfNQGTXeI9SMqu/iDTHaiqfeN026vw?=
 =?us-ascii?Q?MZDx6oRri3WhQ3UtfyDhLyx3S8WTWTmaWlECStSJV/hq389FQJAiMLdBoZWV?=
 =?us-ascii?Q?WVgDjmYEBbgRwr8dyYMiKj39YW2FySMu8nwEKjSLGiHYQ3uD8qhwDKbVWxNA?=
 =?us-ascii?Q?qmGWP5mmAddvaFto6arISZ/OWcMnQj92PiQRVUMok6N6fRKsFQCtracq/pTo?=
 =?us-ascii?Q?dJ2YJkZ7rYleRasd6jhNCZydRAiHJFuBajq+xdgTmSswkmfFnso1KatM/7yP?=
 =?us-ascii?Q?MpcCyM05wawE5ZvEF0lnmh9dJZGxD6kJJ6gJJ09Uv4lBprhI/CS9raoDXubx?=
 =?us-ascii?Q?vqSAEF/hSYQKpXVKpQma69P4qg9Y+17dDvQliNvG84Gq9/3pbInHQ/es+ID2?=
 =?us-ascii?Q?Lf7WZvIOxiHYW4VAM3wL4+1Gjpq4WfuNKoP/V8uDH7jlnB8J1IZ+pa+z2oEJ?=
 =?us-ascii?Q?EYwZUK5FksGBZg+8/5WCUhe0R56Mw9tTiIcJvU3Edd2kjp6FDfhtD6wKHhJP?=
 =?us-ascii?Q?jm5knn4BcKMh8nfOlkHks78P/tptlRG+k2hJYcubnyB7wENUvLsETMjyiyta?=
 =?us-ascii?Q?GawH4wsxpXo9iNF4MR+8WCQd5NF0Nq6zhfhUc6R/A4t7qoaOcJSmHXhofbnT?=
 =?us-ascii?Q?iSknYcWT3TLjEbu5Z0rJOv974yhl8HU7CiQwx6XzSA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Oo/hAaHPgdblTC49mXteb4x9Gx+O+naNgmbICrIviACnC+IyYtV3Wf9eYLjV?=
 =?us-ascii?Q?UwYzTtEm4r7TFadNQwXivi5uiH6Zl4rIFlAlectylTuZJ72dDhxE3/k45Ma7?=
 =?us-ascii?Q?08dTjaQ7EPRnIk7VIoSHuLugJNT/RCVdJn2nJSnESom85Ene3yPqrzh444x1?=
 =?us-ascii?Q?o7otfukatQe8DFvuI5ISCiRvDwbbFmqw+HZq3X7JEbwDU4tKmglfWhq+3M0h?=
 =?us-ascii?Q?PqfTRvK6XBwJjL0uxT0TCoxvYoz9Z5e62Q/LCyiiyG1V69LxVaKeZGVMW3mD?=
 =?us-ascii?Q?vzbzyxBm+Iuyye7x/+NMHYEKv15Gm7TuVurBki6EI5MPJoAfF4paeIhcxwP9?=
 =?us-ascii?Q?FFPhlFdoD0Gp8FdzUjYRugU19rLNZF25BBO9V/NiRSRfnFvVpNue2xLlkF5R?=
 =?us-ascii?Q?xfqEtZFETFPCvY2hB0n9FudWjrix0UPiCmNXneHtFMaFqHJGN1tuvZA+ohIZ?=
 =?us-ascii?Q?vXGTibJCz7f4+E8fFjeQsIJEsaRor5X53D3RQ4rZmSPKDLFJDRyP5YXFTWsV?=
 =?us-ascii?Q?zAXCITqPBJDHSph3wTcCLk9wYNTJ9ssV3JH2tEAXlZFX0W57bB3k7AMwxeH5?=
 =?us-ascii?Q?mC6A2uBIIBmQwGO7gktLUokG7s3qVG0Dn/XsWn2enHrqx8oAMlSGF6dqWecX?=
 =?us-ascii?Q?Zb0OKlfbrTUH+GbgGX5LPPaJ1hk4emE2HlUQCxSaExNBPvR6wgBFp39LfBNL?=
 =?us-ascii?Q?qSVvpg4qznfzF2sN/FRogLgtzvQYfSVQriLyA9eFAfzhMkyBP7at5eUJcFZ3?=
 =?us-ascii?Q?pMIvXxCH+cHiEwpsADaEXXHnMHymsN4yixcpGdtw2/HvCArCfcT8Q9b2m/j/?=
 =?us-ascii?Q?fKll0wt8lB29kdPoJhoMfqcr68jP2xPrid9xaALs8LHPgUL1L5dmCJw9R3xD?=
 =?us-ascii?Q?6auE5bgeTo37EWgP/+P2yOAPqoRaSk21dfVNl22dKVXy1tsTYS0Nz9RmKKh+?=
 =?us-ascii?Q?JUXyU7jPhujmrS8vJwQD0mhZH5tULbnqu7VameVFWHkUrVviTbqWsQKNycP3?=
 =?us-ascii?Q?PTLjbOxZnsjRK1SG0BnoB3CDUvlWAPlix09kLoiaP0/aO54fHBT+AE6Yij3j?=
 =?us-ascii?Q?mcWfUR8XG8ttHNVuaL23tw4zrxY6V9+k5a4EzKeUaBqb8fxKP5YJw3dS2ElY?=
 =?us-ascii?Q?4W1WdDRu5/6+BGOkzq0WUErQSsNkO5twgeOdDOnLgfg3HjeEctu1tsoCFdlC?=
 =?us-ascii?Q?ZKSyGCsBDRDBVDGqXfUyi7zWcv8385cUYir7VDUV9qcX1mj2hxAq9C5b0aLQ?=
 =?us-ascii?Q?Dc8i6uTt/pPWI5QiffHq8nTSN4KM7UjSz2T9ip3A1QTQd/E+WqoE3lyWpAdl?=
 =?us-ascii?Q?qOhDzrhqnpu0v9V6RNKm/Jlqx1hDxTtaa9r5yodKcrp8FFOWIxYy0gNhH0ap?=
 =?us-ascii?Q?IyRXg3z4Yo4Sk+/VzCLA/H+/NHncrNxM3BJkFtz2iTmUoVrxHycVby0g6YSy?=
 =?us-ascii?Q?MZeLsxovkpaLtl4euuxjNVQ98vhFZLGvryrboLpm7lO8YdsT+4jRNUE2ugOJ?=
 =?us-ascii?Q?YB89tyhNfooeKyXvuKrJABIrsPlTWAKR7KSRj9wOdQOAGHqdf7O7Rr9Y6nQx?=
 =?us-ascii?Q?/TmWr9wrWN382XM2YdHcQenhIaPK+7ytbJcUoQ0edT/UUMQczSV07Yso0mb3?=
 =?us-ascii?Q?hxy9wwhzmz8B6hFwHY38KNE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	b3cCxE3Bew2uK0/2CNZwl1chWPszc8Fe88vHTey5PV375q1/S1KsMLj/z3RXYTCSOgDtuWt1Np8nRHtGg7Hv6rrIVPUjpVMtVjVySnWn84uR1IkdGlQVfM77/hGZoif8sTcqWuqXpRmqAqrk606V1Y0eB/u5ORA/D9g9LslzVMeedgfXYdoAZgtAOInOSTfSlasQFKp9C4LLnq0+K0ct5GmUFhKkeHZlIMKNFLgHa3dKQ+rCDBzR0aL3mJm4SILQCeGmzjODaYK7I9+QpKnYejbmM4tLDue69co2ZqK4eE8EctywhQKnXRt9XZvGKjeVSMp0HK76Llvc10PLU2b6E4slrXNjuFGMYygGQf3Bl3qNpJ+fvmUyfVaNJk/wSUW85lNArGw5UXEbN5c96buEDclBqarrInx+RFMrZaAGYt9vGQQp9ztI6jGZiH8iwy9x3A8PmVu6CoutJU1HPM4oK19mCbWzTYunDOsnPwALKIKL0TGjhooc3fzF3g1FK8/sx9ZXvLGSveJtKaeBEWXLi+wb84O5XQ/e6wk8qob+iy/zRVxRImZrHV3xUIUF44aSAx0N1G+tKgDEDwrxe1An8ofHnH5TPrM3aGddGFNGyPw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b87d484-0496-4cfb-5ecc-08dc6e9060b1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 12:22:35.7852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90LK6ImxAVialNI6qYvUVbpWJ0beMBR6exwe1uK6422Ft/t8IRkLKzt1vww5g2DfGb5h8TG1bkk5M6A9HR7RZ3smLGHT/bvOBI0E7DEPOrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070084
X-Proofpoint-GUID: HY2H1ZGpn3-vsvRVDYa0TDVWfNwhUUP-
X-Proofpoint-ORIG-GUID: HY2H1ZGpn3-vsvRVDYa0TDVWfNwhUUP-

Hi everyone,

This is a new version based on comments.

Regards,
Cupertino

Changes from v1:
 - Comment with gcc-bpf replaced by bpf_gcc.
 - Used pragma GCC optimize to disable GCC optimization in test.


Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>

Cupertino Miranda (2):
  selftests/bpf: Add CFLAGS per source file and runner
  selftests/bpf: Change functions definitions to support GCC

 tools/testing/selftests/bpf/Makefile          | 17 ++++++------
 .../selftests/bpf/progs/test_xdp_noinline.c   | 27 ++++++++++++++-----
 2 files changed, 30 insertions(+), 14 deletions(-)

-- 
2.39.2


