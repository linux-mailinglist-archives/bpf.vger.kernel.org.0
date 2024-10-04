Return-Path: <bpf+bounces-40968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BF8990A1B
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDAE28430C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB21CACED;
	Fri,  4 Oct 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SQ2Pb7ZF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I6enpX1C"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAFF1E378D;
	Fri,  4 Oct 2024 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062802; cv=fail; b=eoVG8CEO065ovVtpY/dXS4c72Pw+MQFwHw/OfvoRFqJjXroVX+RRee6EnjMJIZYOet05bMDPbtQnyDWuo8hz/+vbWEyzz9Ivg0Gz5wIP99iop/0sPN3QfPARFhFOynVS9NSoI2YYQv+T5QgH3PEOkfXeGKLzX0cTVz5KxJ2d4t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062802; c=relaxed/simple;
	bh=t4qmbLO0VYKpg3RusnN/yqt0ARosjrA/KZBiIv6Lb0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B3SFU5kH4M7sBz5giNBnToXSgmvweQI86BvFt7mLlgeqYQ4PP4ME8tLjgUWV7IljUIQStaFJhzrzRIa7EXG4uC0RZyoHmYDvBe2/gchSjceGJNlg8YIJRPETG05UR9go+I4sJeu0fXVbvKUL+r+RqZqnX+IPhOMQMmiIz88vjD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SQ2Pb7ZF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I6enpX1C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494Gfu1M015209;
	Fri, 4 Oct 2024 17:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=2BoYj8vJoCc5YOGcljrF0j59xv9vGYkaEkCcW4RMm0g=; b=
	SQ2Pb7ZF5BzQT5aOyIhKHHTZIKWy3o0dSxQAmt45HhRCLiMhoHLNEzP3VJEs95g6
	e/cjtzYl62g9aC0/npxuJjac9Y4TMfZRVVlSQ9ZOIna7oIkLfzQO7v5g/nR2W5RS
	KXlqCRFHOk+YgiuOFDu9DrcuBVu6t4MSmz/FOCF+tDpzHspzEAJnHg5HxumdRDjh
	24M8GyPBbdNqhEzbR2EIhvYl3zKaedHQbdO7mbgQyXYl4/rSI4MB3Qqbdk5jyfju
	KvWfI1JXfIZg3MweRA43jUv3XvNSjEQKcomZ+5p9JfUms/eabZnfLFsRmfdugVbR
	intGiRVIQg+MPxFEwlOSmg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204gt2qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:26:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494H4rGM005877;
	Fri, 4 Oct 2024 17:26:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422056u661-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDZlIN5COL/in4RSmUgTwP4iqnG6vLTvm5o9XAvD2JRJQ4ukpyZpOFG4cMqGPi/TGKV4hIVlzqMSXfcRbOAySd6T+14TkCj1nI1ikTYMRZrAaXz85ium/WhSwSX1VKYPSYDKDX0QVhH18m08x2+XZ7U4lRW3ypSdE6rZk0rg6holmGPMWmzohcbqelpdm6KWgV3e799GQbFpiV7Zsa0PDkqgcf5BQziqs6f7QcrAe2Ko/UvgiCBnfWwxajuVevUPEvYYf77ZaaYS+Rd6DHDsYth33rMB7JrRGwVs6ZtdRNspNuohSRIyqjsCd30/SP+K4FfvnBkXzNCbopG7w5E01Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BoYj8vJoCc5YOGcljrF0j59xv9vGYkaEkCcW4RMm0g=;
 b=wYS30qKwEU+iJh4Q3vNr5LAZI157DSB8N3xWZode5JaJPmaZcBUN9hcuQmm9LElVrv6XD01N4cDLxMfX5StgxMEREIadtybjnejIdMOWsTrnQwSLsUPOISBdUKOJYVCXXwDp1K5oTZGw4YP5okAdSUn8lPnsTJtO3i5vHxr86bnnUDlFTqC40wxtYpQ3y9+sujfHIA0SilhQ353mJB5pYTq1knhmmMkx8xAAUzXe4mR4CY1p2tM1g+6+51R+C4ZGBUteQ3vgcL8Fk5QZWT582BrqFjqIYtE3fii3HPT4ZS5URnDGfJn3hPPi3GcFKa9+rxieEKwW/YHQvGs45N2Cnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BoYj8vJoCc5YOGcljrF0j59xv9vGYkaEkCcW4RMm0g=;
 b=I6enpX1C3Cj664izuhhEdedMJ5lJtdDf14TYOtetY0GT5MkjvdDvPPacFMO25KVZSPFji4QZeKACEhAlBbSdskVnJ4Bfg5nlHGwcOjmv+2Ucp47S3A3ZBKJYfE1VfzvMusxhlYoGEl9vddb7MOVOarR8ErdPA1a+1rytIpfyKf0=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by IA1PR10MB7485.namprd10.prod.outlook.com (2603:10b6:208:451::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 17:26:35 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 17:26:35 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v4 2/4] btf_encoder: explicitly check addr/size for u32 overflow
Date: Fri,  4 Oct 2024 10:26:26 -0700
Message-ID: <20241004172631.629870-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
References: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::35) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|IA1PR10MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d637c7-9c70-4d43-6f40-08dce499b24d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lek5cEipHLFmu31z4y3VDNqOBo52MlqjVo1VAGYlSHmBWZ8Si1j3WN3sHjAI?=
 =?us-ascii?Q?aatgR8V1ktbF7tfq27ec+nk2ZrCyy8k7Wwd4oqzhpyjPK+gfIfbLP9akQS8G?=
 =?us-ascii?Q?IA7T2NDEix+vAfl+noBH9SfAtlgE5r9Hm12crNlGBK87VhQx86dpJZMzFpD2?=
 =?us-ascii?Q?i/KvAAMklBZOHE2lnoYUmDENoXtL/aHG+y0OTlQJuZ/KpQxq0L/h9uGhcuRf?=
 =?us-ascii?Q?6M5EF/aQb59QWwkgIB9JizIXXVd60sD0FuQMZc0ACV4O3soBu3ghLQSZvrfF?=
 =?us-ascii?Q?W9t8IZBnLE0/htWimJ9Ok0aUJF5cFqUVGN480FaTzRbz9QO9hDrorj1Tl+hK?=
 =?us-ascii?Q?A61VT4c58TZ7xNsbGlbgH2KbCOdgSCFKpnwU9IzQX/JQlzAH3f69okjHO1bO?=
 =?us-ascii?Q?Iq9AzLTIf2npqOFkj5vs4m/9ZdoJYQmlzcisqNOiLk9zRLL5i25v/L+gEF7Z?=
 =?us-ascii?Q?tuZyzB3sB0Dr0Y/VZfHRIDMif0VZRGgFkNS9YQFNBslmwaz+M5Cl+xY7rG8e?=
 =?us-ascii?Q?9oROeIOGCSrJ6zdF+BByiDxdCWGv+Py0fKQ0E/9ijNlAWfVR6xueFDMdgDF/?=
 =?us-ascii?Q?uYbEoqtvgCImxCcd5mVSoKvTklDa9hAIGwizcwcaLnEseaGIpKfcn8PTtHCq?=
 =?us-ascii?Q?h//WUwW8esnAdjCS2umXYuCNdiaUMuKAyTzp5Oe5UXG2gA7+vKkH57O4mbCC?=
 =?us-ascii?Q?XK96JqDRGURWvVTySqT2dDFUIPKo6SauQptNxqrZmeWJsiNkj0WnT7YKOljd?=
 =?us-ascii?Q?qvfKIzLusfUlAS/+HqrXsXsIw67oIi7fkyqrVHad/GOkf2qvigfHwSVVbMMQ?=
 =?us-ascii?Q?8D+AMWfJj3hUiihGwRi9l/h3hAwbLWmLLKJPOoD3JOlO6Fu08djQMgPG8vOl?=
 =?us-ascii?Q?IfgONOYQJAjS+xxRe/5HNvv0R3Gw1kMtXH8SO3W0Hf0olXHNXokME8OxDd3B?=
 =?us-ascii?Q?JFwdJpg9pvdqthJbkbMLioPDOum36VrikVUGwAgtGrKBA2OsSsc2lEifOLvm?=
 =?us-ascii?Q?bOaR3nitfkZyLkiYjaZT5bDVjvFbRKFZO1+BQk4QcFLm3qM+Vbx0WQZDD6rM?=
 =?us-ascii?Q?hQwByqrYVQpLCbiAHnBvg8CcfdifwmUKc2gl553JacH4x3YegJiP5kdHzXQF?=
 =?us-ascii?Q?FKc4sehSEOJFNMxxid4UoSLwUTpvtQTnsC3TQc5rRqU00iPXnOw4A6etqwOx?=
 =?us-ascii?Q?H1xD2WeIeM8IvBnOau/9ejcbQ9y8PigiX8bT2i6q9eUqxdATX/UmwBWt8sBV?=
 =?us-ascii?Q?Ic0gN/4xDQ3edqrEwwccTcWsojDHVlF0IIKOQSlhVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nr+Mfv2vYFdK8ZeucmEQAlOcDpk7DLp3qlJzT99frPD552zGNtyT9bazsJAY?=
 =?us-ascii?Q?J35lqL0WBvvaY61uznWqA372p1OwY+e7DAkjExXVdJl+gd7a/1RDcp597BtG?=
 =?us-ascii?Q?XsP0kxZSx0OIizGgIQJqBhJbw09Fl0D57sQKYZ8DUrAEGu76VnuvAZlI25HO?=
 =?us-ascii?Q?2r/82sD7aodv+Rb1j4I+wfN/BNLFtSLFtdIj4M93KPefSWNaieSn3koytVZq?=
 =?us-ascii?Q?H/iLsvjRh0LSiU5c3L3SBxgN75HVhvwiSc7jcAfA429McOn0bXU4B2ETmU5+?=
 =?us-ascii?Q?vLrTm/4LAcJbL1b9rspfKUlQxKF5MxrZCSTGamMtIq6laMmskAJ3jXhkx+1q?=
 =?us-ascii?Q?3RjaWDga/acZkLd3nSpzHWol5FgJzQMgSmqim6W3D8vWdCFujReFxdjuoKyp?=
 =?us-ascii?Q?KUH0CsT22TyJhSZpOtoSjbWWyYaqVaWDBmUBDUx+b+C7DN2PkWoT1mbdncUZ?=
 =?us-ascii?Q?a8BP0xzHVt5oYmbKtTCJ9wtEzz0LIStoh4gU9ONe+1/bkk31PFHz4SP8RYT+?=
 =?us-ascii?Q?N5n9ZhuTt2gB2IHu+fbsFhsoW2abQFLAV0p3GrYc+IOScbW9Vt0hKgN1NbsK?=
 =?us-ascii?Q?4h5An72yt7IX0Tyc8mTssowcfEagD0Upvw3ye2jd6KEhC/FDSpmrfocfJtUm?=
 =?us-ascii?Q?iAD252Y5GNWy0y4zekzBWbx+bwA0ZKAtBe7aiZFl4NolNaigESup51aMUqh/?=
 =?us-ascii?Q?PVnWcNibanjuQk+3KsF1jJCc5lRack3XrWW9al1ySBjqEnHWbIN9VXeGK7OW?=
 =?us-ascii?Q?D6/60bOh8kSbrFynU9ypYsC6RUytAidaC8X3ybWHpXVgMq5liEgNgNvJUFP0?=
 =?us-ascii?Q?5kNgerp8lWUCZouquEU87Bl4eM+NmGqIhUH3RZAwbJykNc6XoweW86E+zRp8?=
 =?us-ascii?Q?XGVCBu1yYHx5QVjztlwgWDELvcGsviTF0s1y7Z2oVClsHG2tv6N20Xh7VcA8?=
 =?us-ascii?Q?jT0kSRW0n4Yzix+02L21lp5leeU+OnLtvR8dZor8K+MqgBm1pxYzGNLOr4JR?=
 =?us-ascii?Q?JO8J0ZpVbvO2+/SFxfvBHko8Jh3WdmLt7MTB8GdW+xiz66aa31QKE9R1kXlA?=
 =?us-ascii?Q?Q/HHpfexUO2st3R7W2m0THCCuETjbHfTpLqHElGqp6SMmdSAOFtg9nIlvPfG?=
 =?us-ascii?Q?k+DE1uZ1NzKfb4LMkRjcz+1bY4aPweGoctYbVCIe0MhYFNT7OAbe9T6yHYbQ?=
 =?us-ascii?Q?Bnu2pdQi92Wa9EwRA8RXwhKOotNhZmwgiT2gWtjwHJMahUpa5oB5KiF1FJoa?=
 =?us-ascii?Q?OzagnCIc8J18IQJB7zAQVxlkkOxlzE8pzhZKsSLFqjqoDmpWx1jTXpmI4+Sr?=
 =?us-ascii?Q?gCMZt9n4DKhqYHPPbyseSmSeGzy+vLPTYp86jKwh4mbCFLWicHw8x3a758c0?=
 =?us-ascii?Q?/R9pH5E2+8Yt9y37NGgeTrvmFGCKmDxZj7/zYblHM26BmQubedJLeBBYb9iX?=
 =?us-ascii?Q?n64YchgxBnGyMLYl2OvOt8eFJ2pWuVZFHpGDNbGvXWnhyTD6Tq4Qx2EIQlaf?=
 =?us-ascii?Q?ghbA+BlhN/HgeWs2W7DTdGULLaX+QMtHEJrSrAxI2slQUzXRHHgIGBS3tXjC?=
 =?us-ascii?Q?cRTEiqCYT3cD9xrk7ZaB7cqh6cbJAvFgO2Qn5GnoSGQnHi2ySsQg98RuGZmi?=
 =?us-ascii?Q?tbFjRBsiuQWaOmyA320iP34=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R2X3xu1wymaRxQFlRCGS8Sp6fh+Te+BS/+/Xo8RY5AfRANrFQ1m7iSX79rKZriJ7Gj0tGO66NQByTSvlm08dH4jLMNuFmaCRncIeyMuMC+Ot+P7IoijAUj0WS6SY4LOwImzQioR8jc26wU+H4c8FU1UY/53c5Qo2o+WQ9el5QXs17oDw2Ytc+V5J9FZKFpUiA/pLrJV32YOWKKl6Awv+zV/VMzKBdOtAby9UMndkSjKuQQkCyMEip+hUKrwPVVuBiadcyL/D25nZ/BBbm6sWB4hv8ZxGMvxeAkKTyeJwHyrUGzs5uoJE/sL1CkfvSeU6Q2r6BCJFNay7mvq6yyUbVVuGe1Dqe8uZIpfgi78KEKqgZPVhpkRz1XwSVrwe8TsdUSmaJ4zKQgVT2/TqLVlRFbCRuzpFvLZayDA5HEaAhlCegWjK2yGskjFm4J8fIdy7vvAJeOQ3zawRaViM/oWBdG33ugGC++mDRWV3tNXqv6OTdAPtPoQPg03UQOZ6UMq/rjfTVGLabMOoIsQ4Alh9zjfmpATnOHlN9RI6i+xZGHSJtgXDlTwNC+YzXI2BU9TCWPl/EM1ylrDYjmTXM4YoSOUHhIvlsCfRI48RtjcgMkc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d637c7-9c70-4d43-6f40-08dce499b24d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 17:26:35.4306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3MPrDn+vCcQyIRsnKVZ4+K8hwj9LXchZl/KWXZQAhBroAbPTEmfhIDb1TDo1f85VVaqEU3PwgXODihOFpUy6oHuWTh9DOp2lccfcHcCWF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_14,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040119
X-Proofpoint-GUID: XitPjNXmN4fx15f8_jezt1GHu7n5b7Ba
X-Proofpoint-ORIG-GUID: XitPjNXmN4fx15f8_jezt1GHu7n5b7Ba

The addr is a uint64_t, and depending on the size of a data section,
there's no guarantee that it fits into a uint32_t, even after
subtracting out the section start address. Similarly, the variable size
is a size_t which could exceed a uint32_t. Check both for overflow, and
if found, skip the variable with an error message. Use explicit casts
when we cast to uint32_t so it's plain to see that this is happening.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 61e9ece..5586cd8 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2253,9 +2253,16 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 
 		tag = cu__type(cu, var->ip.tag.type);
 		size = tag__size(tag, cu);
-		if (size == 0) {
+		if (size == 0 || size > UINT32_MAX) {
 			if (encoder->verbose)
-				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", name);
+				fprintf(stderr, "Ignoring %s-sized per-CPU variable '%s'...\n",
+					size == 0 ? "zero" : "over", name);
+			continue;
+		}
+		if (addr > UINT32_MAX) {
+			if (encoder->verbose)
+				fprintf(stderr, "Ignoring variable '%s' - its offset %zu doesn't fit in a u32\n",
+					name, addr);
 			continue;
 		}
 
@@ -2288,7 +2295,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
 		 * encoder->types later when we add BTF_VAR_DATASEC.
 		 */
-		id = btf_encoder__add_var_secinfo(encoder, id, addr, size);
+		id = btf_encoder__add_var_secinfo(encoder, id, (uint32_t)addr, (uint32_t)size);
 		if (id < 0) {
 			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
 			        name, addr);
-- 
2.43.5


