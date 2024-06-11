Return-Path: <bpf+bounces-31859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E83DC904299
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 19:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCE51F247DE
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A0E57C8A;
	Tue, 11 Jun 2024 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lR+1DR1h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e2jqc1mW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6A24D8AF
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127678; cv=fail; b=IZxKH2b+9eDz2tYYx5LDEjLbMX3aUGPQW0hUGU7dkdDwkzKeXhOEkev5TJq6iFVtHnxo+hPMUaRuNrOquBEUC9wuGzmcTuLve2aQ5G9g76/sZinTFV7/9iI6e2CvlwPRovMs+yeqp4ISme44vbhy4V848FjkjunR83qDKJLCpm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127678; c=relaxed/simple;
	bh=7dfuO3heqRIV252o0YpNzE4/VZdrFZt8IU3TijF63Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PiF2UFOLJkNP7oAldP6e8BK6bXrHpd8wkGbjHBsLb4mRD5UTSwU7eJ5o3xDIABiICtYcYFUXJkmdPRncQeV3UNCPUyPkAyTlMoGu2sQO94bDN9mcbvpMgL9RB/RFBGoSx2HhBgVG5IMaoPl6NUevrm5HDFKA6DEHJ9E6PHOfW4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lR+1DR1h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e2jqc1mW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BGAXc0006124;
	Tue, 11 Jun 2024 17:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=JdrM2XufRhhB54+UX0lFc/MJgkkgFIFLA/JV4+J/3uA=; b=
	lR+1DR1hXo0Kjvgd0dBQLKNELu55+rcne2uD8xr83YjZp5CrBTV+9oo998kuyseI
	luN/sBCuMFYEwrGg5N8bbT3djbyO4gVZi7FeV43Cl/MNyMPamAAlF2tPTb2myx1A
	r8CWvA+uEcqFQbnThEofoFy1n9AA8o4scOK7HHh3tBv6EAD/QhZSUKeSIRw7JAui
	0NHA3nInu2QBs2wm6kL/MwuAclEfVJbvjKfhuuYRFgoMddAWCpqtX4Z7kl6RO5Q8
	kj4jhfQQVpWWuJM1xuEHEBKGzxec8k1u3Ha72wsFZej7jBCuwsOtYn3/qQE6bpNF
	/G7wphuQ2LwnWeHXAbCaUA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh3p5d7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 17:41:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BHMu6S020032;
	Tue, 11 Jun 2024 17:41:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync8xj34k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 17:41:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU2g84JzDTBxDeE8ceYsWeGv2kWonJwP9xTXhQJ2ekcjC/v3CCcSXoW/QlwqaeZ3S59GAAYf7hsTV+zNUEg1CoFTbtBY5XTcZwSm2dRJwAezR38sQzbG1MHB7LRoshV9EuELBydx8DOpEdfxNulp2L4dRuq8jDPUTlLTIpL1kPBYuDEtGr3xb2Dq62PFDX5lcPcbvKugsW+0OpVmntzlLs9hLcyEJytSUdzlNW/r6d9CTBlSyqr66cvCwCmXZLJwHZUcldSfIzF9DWOTvWuKtW3Hz7FisTJ0etY7y6B0d93pR+84BerXyTTlSrraIF5SAI5VS/7FhEDi7snFJoht3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdrM2XufRhhB54+UX0lFc/MJgkkgFIFLA/JV4+J/3uA=;
 b=oKuOKTTiVTVSNFmUPVkH8OzHRquGfdSEEYUkLd4IAhJF2fbWHXJCbU6RpPG9O+5pDBPe45uIe8qL6pHi/FsqcJlxh3fNKXCYS/9TmDAOSyQMf7eXr6w+Gkc6wts5AQjN4z5qPzeeIRGVX+D8pbUoYP3XKzgsZx8gfRs3JlIJ/MdXN56SPBgWEh9cNdehfNk5UmtyfOuiazmU6W//98TqQNIaJoGkbRaQbU++cct9wIigo59DCi8CDcW9Cskp50Tn2KOoZ0+rPbEfeIPt3ZE9lvAX0Fp8GRQpPQmFvVpisEkuSXPMTsvf03eIEuAxw/EQ44iXa1VG1d7YtuXId0bZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdrM2XufRhhB54+UX0lFc/MJgkkgFIFLA/JV4+J/3uA=;
 b=e2jqc1mWKthbMCta9nrBNMQVaV/xNUA1R9NBVA8BEu4Li5uU/sa3xLHVYqmwJh/YQLuJ7zR8cWDxLsyUK9B5txynoGy1dbR3Xl31lZAWdSE3RBo6Rkg+3uEROVMt0BNXzEbcI/7W+8MY+39RAtEwRNOGJAY65eQea/w7LGEnVk4=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS7PR10MB6000.namprd10.prod.outlook.com (2603:10b6:8:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 17:41:10 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 17:41:10 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v3 1/2] selftests/bpf: Support checks against a regular expression.
Date: Tue, 11 Jun 2024 18:40:55 +0100
Message-Id: <20240611174056.349620-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240611174056.349620-1-cupertino.miranda@oracle.com>
References: <20240611174056.349620-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::16) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS7PR10MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: d588eaea-33ee-4384-d703-08dc8a3dae35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gYav8YXQb33NMBciU9svz/k0x3WqGym2l2y3hQ4oJwoiLdB2FdNTBSHTYsP4?=
 =?us-ascii?Q?nbQC1jCiLx8gb7zyrvDTvy56IJe5faM0IY2cOQU+36lWvF47WYb5i5dXoQGu?=
 =?us-ascii?Q?EWdE7DxwKFRdYXAnFgSS6eC74NzteeMHYNih8pzCii1eD2yZYFkAMyjuS5k2?=
 =?us-ascii?Q?tezvDl5s3bvq12qw+N7AIHieSeCQgx6UPbFAY1/tHG5w2H3A2ihbtJfZM4P0?=
 =?us-ascii?Q?rtamc21ivfZ03cZS/dmIHeTAVZQJsfnOn58fpLFjMxaM/l4TVFBy4fGA/CKd?=
 =?us-ascii?Q?1wKv6QxWRFRor7caGwSxwkUGP9TU4GfMiiR36ute12bSJUt/dsH+zjm7CuOq?=
 =?us-ascii?Q?3VRQ6IYaKC3xxpdmoQ4G7elDi+BVNTkhDhbeAi6Zt4PbkEIma/fQGBnthM8x?=
 =?us-ascii?Q?koFUrdj/On3Q3+xBU+SbSOPnhQDIHaYsIhU71YIzhw3NkmScGe2ubGokY/D5?=
 =?us-ascii?Q?QIuC4YE7NOhDg8alUKeuCcn0Zojoi2tbWjgPO6Kt3bJjIFkOQQ+2Z19d/ge5?=
 =?us-ascii?Q?DObj0b4YtgElhV5bc9zD0bFDjIPrMeaE5hLotcIqsLzPc5YFxHvLwuMqB00F?=
 =?us-ascii?Q?9nhO+AkZaxQR9mouQVNQZOqmUxrbsfwx+kLn+R1SstT8eGNXHn9jUbB5051C?=
 =?us-ascii?Q?QdBmnflHwnFwqB7q422Z1xk8cbUxb8MEdCzIagy5evq58IXq2xd6NzDKrJQz?=
 =?us-ascii?Q?jeHaVpCxPXIYgAMya8p9jcTD/pFal398QFq84jZjcfBOIV8rb69TrloIUEnC?=
 =?us-ascii?Q?T+MwJwGGGP1L4PkjJuR8MrWBzEkMulIiVc2x6L6d87S91qqQWybNj3R1DDx0?=
 =?us-ascii?Q?xlXI3bD3c1qfCdTUr6FYgAysYVPaVgJK6hV7hHkhAu4txtcv+TUP7kN6TulD?=
 =?us-ascii?Q?HFe5gCYpYe4oEf1AvY7ykIUYCMwj/SV6F32tM2EZ9wNd++g0b2v7M4z7XQEk?=
 =?us-ascii?Q?JNEQ6JFGR7llWHDXQdN/qkb0Hd3VY6C3hOZUrurmI0qcYzIZoI1Nx7ToJtkv?=
 =?us-ascii?Q?LCdf39uHus/pK9HpOvr9gUsNTpOzkmKXarbVhdyW54EE2v628jf2dsqihKIa?=
 =?us-ascii?Q?90JHy1c8ne3hBKDiNgzgR8AorH888kxI9hb7rNXrCKILn7P62vUy8Jbid5E4?=
 =?us-ascii?Q?rIjJcYetJZYFQSvpKxesJtlaEj3d+V7HrQgU31XE0J5E3B5JCyvjyvzi4nsz?=
 =?us-ascii?Q?Ks1VYZiiSdAP0IY7j2c7fhFaQQeunPBgeXUSMgy9GvCtqluHgkkbN9r3dPss?=
 =?us-ascii?Q?taM1bsSetAgQvVSXsTTiGW1U4FyggzTmcdnHW0uAlUjwn75rX3o4osaE879d?=
 =?us-ascii?Q?SyldgL877K69N7MKyyajIAuC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tsvm5FMHSmkrcaJ/WkWmF9qG7pIzswl0ywMkIp9CqNY+nCbTYDF/gtJIO+dS?=
 =?us-ascii?Q?LrFZMAn3snsE3/7egZJT4Kb5okFJjDcwPyeIVC91Q/CvRaBBAtRYzakxsiNu?=
 =?us-ascii?Q?EqC/jDOc1/AdtnWbUx8DQxOndUhUVZoQuOYF1kd9Lfqt/2uj3U3MrGjXTlqL?=
 =?us-ascii?Q?YkHn6dAiRa7FFwskkSTz7dRK6y/ET2kvInXxXv0hmC72lozfZ2nXa0Gb1SkY?=
 =?us-ascii?Q?NIov9OJSAlI3P1LeNp2k7L6Co82tXLBFWM+jsUxnCRwmA2JxWY8dLFmHgdnJ?=
 =?us-ascii?Q?gxZxoOoLeAIdESKN2u5dFCzXky0glgJe4rlgviCRKpnUozFm+BIQOqZW8+vz?=
 =?us-ascii?Q?UKYH5Mp/YW9naD9D0BVmXE/Y0zquMi254HmUggIGLMRmwAze4jKyKNQUEkbk?=
 =?us-ascii?Q?brVwQQ7iVCwlOesZBXgEHbeGSKXZPBH7c1rmGcQBU2ZNHMjrVZ45/A7Gtj7U?=
 =?us-ascii?Q?oXNEoPOwqYuTlca2XJeDjvpku7PoIKy6Gig1X3wuUISPQR+XB32JiSSjCIIa?=
 =?us-ascii?Q?4s3SLpJJ3IKnlNzzUHefwmV8fhtAzYfr3TnWFxK+7ErnaPol4tqdq/S3WC9L?=
 =?us-ascii?Q?cJfVkOROvNRGwvfzZwuPhK/xjvo3bQgAYJn7IJ4yUxqWI03v7pgU6yut8LLn?=
 =?us-ascii?Q?AHkuc2v1aP03CHUQw90EqQzGwQjDKKxRARL9+rTEKfzwZ1lU1JJqGvE3xogl?=
 =?us-ascii?Q?5qP30b1OC3CTY/gMJzNv/BFiGOrA/1+jQGna0+2JIMwCBQyBR+M/u1WR5JpH?=
 =?us-ascii?Q?lMhRcd/P4CWeIk2Br+0uZdpDw4/iMu6A/UWt2x2HUHQSioeZpKp3YRdr+DR1?=
 =?us-ascii?Q?kQvQIn/Txheko3gbNL/5HU2e5e0QgamTCHYtamKotAb/qaavO9YpgD+fdK4d?=
 =?us-ascii?Q?VLQzOn1DKmpEBR9Im9liMUk3W76BLaNs40FsBNXO+e53UzTUx5S+V2n/RPUi?=
 =?us-ascii?Q?6h2r3raboKS2OKcTEdY8DU6W1uRqFTjfImypLOMzNsQKX2awaFrqpwnkfUyR?=
 =?us-ascii?Q?eeXze7mLpznDd4Xmrll1k0bFU5i3Aunz/f5krQOwzdT27qsdG0um0t7QdlbH?=
 =?us-ascii?Q?8Uw3c3XVYHQtyLr+Ut+dFMtXA28sIUp6MbpHFtmPL+DsCTkn2Wk0z12nF+Nx?=
 =?us-ascii?Q?BF5NFGAC28wjnqfdtDSipZG8hs9aWW23EyVONK4w+3YPzRuj2H9NL28YVWfF?=
 =?us-ascii?Q?6w2/xYimxyKOWDaowWjZ6Ohv1dhHQlAQYH35SRR4IHZOn/4mZzyR127KCSfG?=
 =?us-ascii?Q?uQvE5wpi289Djc2m3U0jVb7NSX9VZ8tq1fUcoWfwxgwy6aelC/Hshx+tyQSH?=
 =?us-ascii?Q?KeWtiElCGGSN/lCJ2dJnzU0a18zF0y50oyrXUhyiIkWeA9Iqc9sToZY9IPhz?=
 =?us-ascii?Q?1/r8193UB3nkzwtf34joHAvbUKCjdt2IRU4pqv4WsunC3zx/3jtvCVxppCIw?=
 =?us-ascii?Q?GhaTCl1O0BflJxVFkAHJOBZM2ISHu+CY36hDaKxINvEM5IG9ZtZ4hw3Kig8s?=
 =?us-ascii?Q?Nf/RPFXvT7XNZafYdEOQDWxc2cdNhx1Y1ZZZRpiSn/a4/BqLfh+xbTkeFeON?=
 =?us-ascii?Q?VQUWPbv0zKhJV6Sp0bUlNYfrX3DmYB5jBhbOahwBONvJZkpUHNmKH7oLONJc?=
 =?us-ascii?Q?7HM1SokMFOR8BTkcg3usEyo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	soIwV377KRZJ/XegWBVzfonIaYb+ZpmutIAyhdNFhM/g37jN+4dPdyUfrzrE5ba/VGPuG43YoGgwnjT8pwN+glkqCIvbI80gq9cz9QhiwDoBCRu6V2vySqpRWpZVhgSdbYDKPJr8UaqblfXzx1l7f6P3NhUFFROxk+KuMYmdpXO/7EdtiWit/4JxlQ5yQMF+trGYONcileiI4NNehQRde+4PkvgACl0DKsGui2IH5e5YLX/sDh1cveocJy4zAujKhynjIaCx6n0yiT5G8X6mwzrrSY4vCvrP7xluwi5HlsEplKYNVOVWmHtgd/0b6BmSV2F3Mewfarx7wPOLd6CAXPi+e14PVWeB30F9RSA4jjBbt0QtylYYwtZx/Lu0p/M2Lg2zscol8t/qGcAn8VC4HoRuGzrxcsb0TPbn4hS5Y+EzjIVF0xrPlTRZXHTRbaZoEjcOIMx1p0DnZCoBYgqO7iXz189a+9piFZPlJE3ACcWs8X6IWbbPPwJZDdbAvKdweY4W9RN6TLTpxheQ7+pe1pKnetbU7bc70qlmcECwJpLSIYNXEd/TkjS8ZA6l65T8AurVCWNLw+XXQYGWZUWbUyiHj6Jfm/RCer3GjFOjqak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d588eaea-33ee-4384-d703-08dc8a3dae35
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 17:41:10.2144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fe6f20bPIpKsVoDvOiafyTE1Imc6YU6ulDEjK46qLqdW3znpIeF7dj92aSH0Q3sWanvdaiVdsWwfvsUJVpF/pXCZ9PkaAatbqO6wZC+HF4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB6000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110122
X-Proofpoint-GUID: ljLSPeOvIPPKR9_NzM2O4lo6Lip45OTP
X-Proofpoint-ORIG-GUID: ljLSPeOvIPPKR9_NzM2O4lo6Lip45OTP

Add support for __regex and __regex_unpriv macros to check the test
execution output against a regular expression. This is similar to __msg
and __msg_unpriv, however those expect full text matching.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: jose.marchesi@oracle.com
Cc: david.faust@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  11 +-
 tools/testing/selftests/bpf/test_loader.c    | 119 ++++++++++++++-----
 2 files changed, 100 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index fb2f5513e29e..c0280bd2f340 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -7,9 +7,9 @@
  *
  * The test_loader sequentially loads each program in a skeleton.
  * Programs could be loaded in privileged and unprivileged modes.
- * - __success, __failure, __msg imply privileged mode;
- * - __success_unpriv, __failure_unpriv, __msg_unpriv imply
- *   unprivileged mode.
+ * - __success, __failure, __msg, __regex imply privileged mode;
+ * - __success_unpriv, __failure_unpriv, __msg_unpriv, __regex_unpriv
+ *   imply unprivileged mode.
  * If combination of privileged and unprivileged attributes is present
  * both modes are used. If none are present privileged mode is implied.
  *
@@ -24,6 +24,9 @@
  *                   Multiple __msg attributes could be specified.
  * __msg_unpriv      Same as __msg but for unprivileged mode.
  *
+ * __regex           Same as __msg, but using a regular expression.
+ * __regex_unpriv    Same as __msg_unpriv but using a regular expression.
+ *
  * __success         Expect program load success in privileged mode.
  * __success_unpriv  Expect program load success in unprivileged mode.
  *
@@ -59,10 +62,12 @@
  * __auxiliary_unpriv  Same, but load program in unprivileged mode.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
+#define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" regex)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
+#define __regex_unpriv(regex)	__attribute__((btf_decl_tag("comment:test_expect_regex_unpriv=" regex)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 524c38e9cde4..bc79b9f6afc4 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
 #include <linux/capability.h>
 #include <stdlib.h>
+#include <regex.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
 
@@ -17,9 +18,11 @@
 #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
+#define TEST_TAG_EXPECT_REGEX_PFX "comment:test_expect_regex="
 #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
 #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
 #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
+#define TEST_TAG_EXPECT_REGEX_PFX_UNPRIV "comment:test_expect_regex_unpriv="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
 #define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
@@ -46,10 +49,16 @@ enum mode {
 	UNPRIV = 2
 };
 
+struct expect_msg {
+	const char *substr; /* substring match */
+	const char *regex_str; /* regex-based match */
+	regex_t regex;
+};
+
 struct test_subspec {
 	char *name;
 	bool expect_failure;
-	const char **expect_msgs;
+	struct expect_msg *expect_msgs;
 	size_t expect_msg_cnt;
 	int retval;
 	bool execute;
@@ -89,6 +98,16 @@ void test_loader_fini(struct test_loader *tester)
 
 static void free_test_spec(struct test_spec *spec)
 {
+	int i;
+
+	/* Deallocate expect_msgs arrays. */
+	for (i = 0; i < spec->priv.expect_msg_cnt; i++)
+		if (spec->priv.expect_msgs && spec->priv.expect_msgs[i].regex_str)
+			regfree(&spec->priv.expect_msgs[i].regex);
+	for (i = 0; i < spec->unpriv.expect_msg_cnt; i++)
+		if (spec->unpriv.expect_msgs && spec->unpriv.expect_msgs[i].regex_str)
+			regfree(&spec->unpriv.expect_msgs[i].regex);
+
 	free(spec->priv.name);
 	free(spec->unpriv.name);
 	free(spec->priv.expect_msgs);
@@ -100,17 +119,38 @@ static void free_test_spec(struct test_spec *spec)
 	spec->unpriv.expect_msgs = NULL;
 }
 
-static int push_msg(const char *msg, struct test_subspec *subspec)
+static int push_msg(const char *substr, const char *regex_str, struct test_subspec *subspec)
 {
 	void *tmp;
+	int regcomp_res;
+	char error_msg[100];
+	struct expect_msg *msg;
 
-	tmp = realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cnt) * sizeof(void *));
+	tmp = realloc(subspec->expect_msgs,
+		      (1 + subspec->expect_msg_cnt) * sizeof(struct expect_msg));
 	if (!tmp) {
 		ASSERT_FAIL("failed to realloc memory for messages\n");
 		return -ENOMEM;
 	}
 	subspec->expect_msgs = tmp;
-	subspec->expect_msgs[subspec->expect_msg_cnt++] = msg;
+	msg = &subspec->expect_msgs[subspec->expect_msg_cnt];
+	subspec->expect_msg_cnt += 1;
+
+	if (substr) {
+		msg->substr = substr;
+		msg->regex_str = NULL;
+	} else {
+		msg->regex_str = regex_str;
+		msg->substr = NULL;
+		regcomp_res = regcomp(&msg->regex, regex_str, REG_EXTENDED|REG_NEWLINE);
+		if (regcomp_res != 0) {
+			regerror(regcomp_res, &msg->regex, error_msg, 100);
+			fprintf(stderr, "Regexp compilation error in '%s': '%s'\n",
+				regex_str, error_msg);
+			ASSERT_FAIL("failed to compile regex\n");
+			return -EINVAL;
+		}
+	}
 
 	return 0;
 }
@@ -233,13 +273,25 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
-			err = push_msg(msg, &spec->priv);
+			err = push_msg(msg, NULL, &spec->priv);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX_UNPRIV) - 1;
-			err = push_msg(msg, &spec->unpriv);
+			err = push_msg(msg, NULL, &spec->unpriv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX) - 1;
+			err = push_msg(NULL, msg, &spec->priv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRIV)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX_UNPRIV) - 1;
+			err = push_msg(NULL, msg, &spec->unpriv);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
@@ -337,16 +389,11 @@ static int parse_test_spec(struct test_loader *tester,
 		}
 
 		if (!spec->unpriv.expect_msgs) {
-			size_t sz = spec->priv.expect_msg_cnt * sizeof(void *);
+			for (i = 0; i < spec->priv.expect_msg_cnt; i++) {
+				struct expect_msg *msg = &spec->priv.expect_msgs[i];
 
-			spec->unpriv.expect_msgs = malloc(sz);
-			if (!spec->unpriv.expect_msgs) {
-				PRINT_FAIL("failed to allocate memory for unpriv.expect_msgs\n");
-				err = -ENOMEM;
-				goto cleanup;
+				push_msg(msg->substr, msg->regex_str, &spec->unpriv);
 			}
-			memcpy(spec->unpriv.expect_msgs, spec->priv.expect_msgs, sz);
-			spec->unpriv.expect_msg_cnt = spec->priv.expect_msg_cnt;
 		}
 	}
 
@@ -402,27 +449,45 @@ static void validate_case(struct test_loader *tester,
 			  struct bpf_program *prog,
 			  int load_err)
 {
-	int i, j;
+	int i, j, reg_error;
+	char *match;
+	regmatch_t reg_match[1];
 
 	for (i = 0; i < subspec->expect_msg_cnt; i++) {
-		char *match;
-		const char *expect_msg;
-
-		expect_msg = subspec->expect_msgs[i];
+		struct expect_msg *msg = &subspec->expect_msgs[i];
+
+		if (msg->substr) {
+			match = strstr(tester->log_buf + tester->next_match_pos, msg->substr);
+			tester->next_match_pos = match - tester->log_buf + strlen(msg->substr);
+		} else {
+			reg_error = regexec(&msg->regex,
+					    tester->log_buf + tester->next_match_pos,
+					    1, reg_match, 0);
+			if (reg_error == 0) {
+				match = tester->log_buf + tester->next_match_pos
+					+ reg_match[0].rm_so;
+				tester->next_match_pos += reg_match[0].rm_eo;
+			} else
+				match = NULL;
+		}
 
-		match = strstr(tester->log_buf + tester->next_match_pos, expect_msg);
 		if (!ASSERT_OK_PTR(match, "expect_msg")) {
-			/* if we are in verbose mode, we've already emitted log */
 			if (env.verbosity == VERBOSE_NONE)
 				emit_verifier_log(tester->log_buf, true /*force*/);
-			for (j = 0; j < i; j++)
-				fprintf(stderr,
-					"MATCHED  MSG: '%s'\n", subspec->expect_msgs[j]);
-			fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
+			for (j = 0; j <= i; j++) {
+				const char *header = (j < i) ? "MATCHED" : "EXPECTED";
+
+				msg = &subspec->expect_msgs[j];
+
+				if (msg->substr)
+					fprintf(stderr,
+						"%s  MSG: '%s'\n", header, msg->substr);
+				else
+					fprintf(stderr,
+						"%s  REGEX: '%s'\n", header, msg->regex_str);
+			}
 			return;
 		}
-
-		tester->next_match_pos = match - tester->log_buf + strlen(expect_msg);
 	}
 }
 
-- 
2.39.2


