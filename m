Return-Path: <bpf+bounces-21057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A368847229
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 15:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A591F28880
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A890D13E200;
	Fri,  2 Feb 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SrFUiQOY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hv7rV3le"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D80210FE
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885310; cv=fail; b=h12RHjB1MY51oRWrGKRGkm4MH6fzRd60lcj+wTLx6ieu7CKxlPptXXatlaW7j3yTAHQr1TBNuLBwv0dOhZkU2WOJiW4seh30e+zoQPst62KTbPLf8r7wn/Ugp3UPc0UXpwtpiLd2UOVyqhiuiLz3S/RH4oueTYWFcOzWsfQeDLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885310; c=relaxed/simple;
	bh=sAWiFsC6M7CnpgigAlHPJW9AO8GNTi1uqrpdcrE9KFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GTIyCgF1Q0KmZEWvk6GCNcPWlmQRGd2NR+dKBqcOfXYsWJaV1Bj/fRbiOTQvthS+kg9HaKwpMH9+07NHaR8Xtik7R5OfQbregHEnfeyisqmQQ+tg3pVWawYid9KMSAEVOQoupSzn7T3b0ylKgn6il7pQeidIoArteYPe5l38DU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SrFUiQOY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hv7rV3le; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412EYL8a030530;
	Fri, 2 Feb 2024 14:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=nV2MsyocPqEgnDoORH9czWO979DoJw31Vy76R9KNhEw=;
 b=SrFUiQOYQhz7GDflkQ0O5V2L82D6pj4R4oPzlPmgVj0j51+mWP/XBg595L0X+H6fDgb5
 9m4vMEMRZaEGr7QPJzxkC6SmQkoOaDKfS7aTwtpaPIY8gC1PtW1bR5cA4M1oMwo7skSb
 YKqurQRtuL5P5X9f1pzOorWlXzAKRk/T/0WYLYSdEvhzzOTezLTvbsOpNEZP7NDOiDpG
 rPbWeBiTRgMayqQt0ieCMf5Zx/gCciOmNiPHB4RfDEIcnHxXfyicyJLwGliuL4iN7u4S
 NqmpnXmTZRI6frovLvY93HnOcpcP+PA/X2ecxzrHqH1BQ/2gis6DI9PkyjjYIaoloHj2 9w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdyrum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 14:48:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412DYB1o006461;
	Fri, 2 Feb 2024 14:48:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9j93wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 14:48:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvUqDKXjrUFv+cB8l/l3CV0AibEfGaAhfHcZAZXPw8NlWj1KdJtqy80VxQzHgLSlWqo8jV5Zsa77xvEqLvAltzcUtF2CjcIXd0Z5QfGPuKbbcvfkuMCJebKnNx1oH9vlCVNA6/IwcWNKie3chQoX/KKd94fNQGDIeEPO+qzi91ozmPVK5qZIodZ8brOBpiHwcV7pPg8h3Fq8IYrO19xMctMz1oBZsW4/jr9yZDpHVgerGsfXgXrtSFnTVrvluvWuGwhl86qMmXdiEoMe6vPHXChTcHj6v9kc5eVOzWeo+OMJEq5z1q/bA+SoqIhQNjvxh952dXurQ6ZISSeTlmiF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nV2MsyocPqEgnDoORH9czWO979DoJw31Vy76R9KNhEw=;
 b=cFBpdEUUx5IB9T1keqa5AVK/zXhTFJx9mX93CvJrytZrRagaRxqYkfYhfwudBjll2tboXgSRjwtA7jbIySLOkcb4FJAErRytz2BIcwYMTB9CEog0VVDXQ2aQKIVS3O0z1jLPI94gJYUwNWPY0JEfX1zylPb14Df7zwQ080eL4gK0Dn7Bwmw663buYecSSNoQxf4K0Fgz6GXCM/2VrjnVApcRWC0iBZfUTh2ZLmg5ZMv6e0Lbf2qULRouDk+m3Q07RPKqd0y35IjsZvlPEp4n3VHxoN47Ome9PeEDxrj8j+kCdv4dKgDIDYOWzRPyDJbP8w+wP4JA204+NU2Bh3Ysbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nV2MsyocPqEgnDoORH9czWO979DoJw31Vy76R9KNhEw=;
 b=hv7rV3leVIJdpgypXqsNwfUJKGJd9ORYGJbKRr9B0TxNauHciBgDyffvqZl6HvqQJLXQgwJPuouJJR/jEz3ToemBl9G7Z2logDCJjrBb9+a1H6AFBm3Y4CVdHzQ05BmIbxlW17xRtRLgSoBUG35bdoQRvJXGTbikoZXmGTG5Ldo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:48:03 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 14:48:03 +0000
Message-ID: <eb6c9222-7c08-4758-a0ce-94a91ddd560d@oracle.com>
Date: Fri, 2 Feb 2024 14:47:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 0/2] libbpf Userspace Runtime-Defined Tracing
 (URDT)
Content-Language: en-GB
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org
References: <20240131162003.962665-1-alan.maguire@oracle.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240131162003.962665-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fa2c42-8079-4221-8ad9-08dc23fdf537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AeygB/GYbNx38j+ODw1wBW4MiGM4mUkwO7fc7Y2Y5hO26oMGUs+K2yT2xXZi/KKY6iV63eFXs1S6KCx2Z3RbPBvliBMWHJyeOAJ9Dwah3yMiG6ullGVOmxASbQpjmMDPkWVVAx2jAH8bn66VbnfeKNTZJ/1Nqsncd+A8RoAewS6BsWvjAeGb3klbEURlgcqRpZmsSmCqdgUG5qRw3wt0DBUOC4HfRx55EwzwWqNVXNeXNWiGcPWUob/7SHyawkl379ek10rQCf8bOZS2THDicJu2QxlAwjbK1wNTKmMJ9tWzRM5N7o1ixgPJAF67F19kpuavYkljikEm6ubYg6BO+5H61EwOLoqTsSFy4kWq5aMJCZSgMW2zHnDhiBgADw/C81tJOtpEX1vSmgqlUNR5TKsYqUfgKSORX2c5ocCwgdiWFcUfYGAx5AlAr01jDlZe3kiTq+Y5jhIeOpSqF7BT6Kq+95G84LbTboA/xoyszV7yj6keOUmNiQtyx39VMff/Xa4bNnfZ1aGjkzFs9hL8F22rJ5Slpz3xgxUHl0THEl2w4MRQ/yNk4Agya+Jt4RbDOXAVGN/jVCz20B390CDSPlw468fAIyuqwZJe/vE49xsdc8VR8K8s10tiLdXdizFXqj4/8WrAok9cW943LSqEMg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(316002)(8936002)(66946007)(66556008)(66476007)(4326008)(8676002)(966005)(6486002)(36756003)(478600001)(31696002)(86362001)(5660300002)(41300700001)(7416002)(2906002)(44832011)(83380400001)(2616005)(38100700002)(31686004)(6512007)(6666004)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0VhTkdocFJzR1hLVGxiaTVZOUdIZHBSWVhadEpsNEhuQ0hXN3BMUGIrUnJC?=
 =?utf-8?B?SUZ2WjZQWkV4Ymt3OGlJQ2dVZHlaV0RmN0FNOU9vTmRFRlFWeVlZQ1ErTUZh?=
 =?utf-8?B?R3ViVGlHT3NpdzFBZ3dySEFTa3VDR1BhZjNkWmFsY0txeXZCaElySU9oZXlL?=
 =?utf-8?B?NXNzVDlzbTVJOWxkNkRFUkluZkluM3V5c1hnb0YxSDkvRHA0a0ZldUNqTldw?=
 =?utf-8?B?U3d4U2xadnVxQmQrSk1EdC9XTmRnQm5acXIwTzRNTDlGWUhLeUE4TUUzNVdQ?=
 =?utf-8?B?eUJmdTVxVDd2ZXo3Z1J0UDdmcWtYbXBxUUdXV3czZ1JEejJISnY2Z3BVRGlj?=
 =?utf-8?B?VXNNbm42bGVDUU5iSW5XeWJIZ1duM0ZyalBYcU5zYmtMaVF2eVFHdEEvMVBY?=
 =?utf-8?B?WVNWWnlpcHZkb09HdjF2Nk9BOERjTCs4eEoxVm1rVGdCaHdBZ2pCN01JRzNE?=
 =?utf-8?B?cThJM2dVd2FYT2s5RDl6a0lqQ3R1YnJhWVNGQml0U3RjWHY0RlYrMDVsWG5O?=
 =?utf-8?B?QXNDOHN0K0tSVFpYbXJEbWt6d1lnaTFia0h3WTQ3cDludXhVRlFEREx5R1RS?=
 =?utf-8?B?cTcwNGV6bWJmTEJLemFsUzE4WHJBOEM4enVNNDlWdjRpZ1VNT0dkSzJYYlJx?=
 =?utf-8?B?UW1STVliMjcrdEY5S29QRHVhVDcvYTNHTDFad2U4SlVnY3pwazdoN203L1lD?=
 =?utf-8?B?eTY5NzZGbnYwU0k5M3NHZDF3ME5ZWFFqMzdXMC8rbm4vdmx6akg0OW5qQ29L?=
 =?utf-8?B?ZTcvc2ljNTlCOWdZWDVrOTc5YmV1bTAyUjVsWXBOclFzSWZXRUlRSGJmQy9M?=
 =?utf-8?B?ZFhUczVrTG8zU2dvUmRVZHB2KzlPbGFxT1ZsSUdwdTZQTUdPRE0rT3V3REFO?=
 =?utf-8?B?YnV2cVBwZ3ZLemhPOWZlblpmbDRRa3E1WlI1WHdrTDh4bFBDMUQwU3R1WVpx?=
 =?utf-8?B?SlVzZjlKa3o2ejZtdXkvQWVUdldUREhRcHFCZFFyM0xldUFZV1RGV3BGUGZN?=
 =?utf-8?B?MHdRNW0zVk11K3U1Vm1EL0pMbTJ0SGlqaC83ZXo5RnJ4VTlBd1Z2elJuekhL?=
 =?utf-8?B?cldTY1JGYmFuK1BFazNXV2FBNzIycGIxak5aa2xpblY2RGdiNW52MG9QRHk1?=
 =?utf-8?B?TWJ1NUIvYWx0TkhTNi95M0RHa202QnN0SGhWME03V3RJeEFDTkl4VVhDQmpU?=
 =?utf-8?B?K1RMYWRjUjdKYUp5MDVpN3IvVEo2cU53OW5uKzZkLzhld0Z6L3BOTC9uVUNP?=
 =?utf-8?B?VXBNK1NlVjVxYlNITFhtVHlhQnBrVDVjY255TWtZK0FEckFjOEc1UUlvMk9w?=
 =?utf-8?B?SlpxOCtmNHhxVmY5d01wRmFKaHFUUjZ3RFZKNGh6cEt2UllmUTVlYWhJSS85?=
 =?utf-8?B?TDFINVJsL2JjOCtkTDJxeEtpdFlZRWxKcDUrN3g2Q1VFamFsb2RmbHUrMm8x?=
 =?utf-8?B?MU0yZWlQMmdBYVBSaW1MdU9ick5xZmg5Q0lndVQwcWxibCtTTTVQcjg1aDJT?=
 =?utf-8?B?VzBVZnNIRXJyZUFEWGdUZHN1ZGhMRGZ5SnBJZXhrNGE2N0ROVVJLVTEwclQy?=
 =?utf-8?B?UkRpNnJLSDdoSHRyakJZRVViYlVncFV6OExnQXVLWkNZNlNzTGd1R2VqNEZy?=
 =?utf-8?B?bVVDNndEeGdnVmVlRDFOMmdOUTR4U0xOYXZiK3hpYjZsTzJad0pOVjR5blFD?=
 =?utf-8?B?ZldUMEZ6RHhMYk5NYkpDTGhYcmU2L2VlSzQxd1BoZ1pvb0xDelNmQVJuOGRl?=
 =?utf-8?B?c1U1TENFTld1aENXcXhTWTRtaDdFbUk2SEVlaGJQVEtTc1phSG5VRHJ0SU5U?=
 =?utf-8?B?bWdhY3FoN1VpaVl2RXkwQ1hnWktlTzdNL2x6Q0RldDBibXM4aXl0ZERjazdr?=
 =?utf-8?B?UkhUR0ZPRFdWSDYyV1RwSENJQkJqWDE3Qys2RTdrY3p0K2FqdnFOVVFON2pM?=
 =?utf-8?B?YVRpSTF4M3lPdEZWaFVGY1VTcXAxYUtsZHZqMXBhTkNIWTY3SkNDTVhlZFZ5?=
 =?utf-8?B?YWNzdnlZTWJpeDYvVVplcmQ1V0M4TmdWaGRlK2VWcHY1Q1ZacUJpMHZRSERG?=
 =?utf-8?B?ejlMMjcyQmgwamFyN0Y0M0tpVUlTcWh4eWdQVXFkeHI1ODdqbCtMbExzdzE4?=
 =?utf-8?B?dURITFhVSktMenhuSWcyTStLd0h0UGRrVnpHUVBJRXVscXRvejJRNWpmNzN2?=
 =?utf-8?Q?xh/xH4Sbgy6FAaNNsg2Vn6g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mPaeJowIAeawiT0MVZ+frpjl+pkSAAmMxxfIkE0Rny2w9st24M1mUPY0SajRPAcwnzWxTVFc1oFfoZTEpcb8fIImShLxgjxU/oRl4rP+gdEWRTU7T4GqQssR1+BTom8mXBFjQaFjrWW0xTHEa8pDCjQZspqnpgw0eUuUcxetNe8cHXfx+91+ebXheJ4AD4ObEO71IMhv/OT3IjsvOzP3X7zsR7Cn/5GRpfMOtqu8N3OsQDAxfGW/s4KQ9Rp9GEmPIymtqQfnD86Rlj+laLL5iaiHEfH7eIYZKjULo30VGzX8s1xUojlz6R1JAUIp9NTeCLNt7QxpkYs7CQTNNmeRre6mH59zaJl9GQ2HYHQif5m5rdxl6T2ZF6PXhItBRnuCnxPoyC35F6RZ2d+7X1MB2viWTfGp26BW16OHzzfmeNAVKNEbJTNErTnHLoGUsQo1muV4oS3NE4NyZLFIKcT4j/krDRHlPPpgd3ipIzEYlonKEcpoDIAMUioFDR8xMsg6tXva/A8xwcQpoQgvzK33BxNf4chzfFdMR8DQfqbxMBJNG9AtnzmZRJd1rrt2eeoalVUHmqg/2TawVXBPNUljwZTCNxIRTsMznqCwDwY4LfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fa2c42-8079-4221-8ad9-08dc23fdf537
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:48:02.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkMDuMvhVmIpqSmScE2jEEkKR2UzrUs9w0jNeP0ky6Y2NJBp2FvzP9Oh7cSlCOgAYJc8wxYC7BvOIRlGcDdWHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020107
X-Proofpoint-ORIG-GUID: DTvOAtM7_B008OoTKqz-0bN1bQhETMgh
X-Proofpoint-GUID: DTvOAtM7_B008OoTKqz-0bN1bQhETMgh

On 31/01/2024 16:20, Alan Maguire wrote:
> Adding userspace tracepoints in other languages like python and
> go is a very useful for observability.  libstapsdt [1]
> and language bindings like python-stapsdt [2] that rely on it
> use a clever scheme of emulating static (USDT) userspace tracepoints
> at runtime.  This involves (as I understand it):
> 
> - fabricating a shared library
> - annotating it with ELF notes that describe its tracepoints
> - dlopen()ing it and calling the appropriate probe fire function
>   to trigger probe firing.
> 
> bcc already supports this mechanism (the examples in [2] use
> bcc to list/trigger the tracepoints), so it seems like it
> would be a good candidate for adding support to libbpf.
> 
> However, before doing that, it's worth considering if there
> are simpler ways to support runtime probe firing.  This
> small series demonstrates a simple method based on USDT
> probes added to libbpf itself.
>

[snip]

> The useful thing about this is that by attaching to
> libbpf.so (and firing probes using that library) we
> can get system-wide dynamic probe firing.  It is also
> easy to fire a dynamic probe - no setup is required.
> 
> More examples of auto and manual attach can be found in
> the selftests (patch 2).
> 
> If this approach appears to be worth pursing, we could
> also look at adding support to libstapsdt for it.
>

Proof-of-concept libstapsdt support has been built and tested;
consumers of libstapsdt continue to work the same way but
with URDT support, we can trace dynamic events system-wide.
See

https://github.com/linux-usdt/libstapsdt/compare/main...alan-maguire:libstapsdt:urdt


> Alan Maguire (2):
>   libbpf: add support for Userspace Runtime Dynamic Tracing (URDT)
>   selftests/bpf: add tests for Userspace Runtime Defined Tracepoints
>     (URDT)
> 
>  tools/lib/bpf/Build                           |   2 +-
>  tools/lib/bpf/Makefile                        |   2 +-
>  tools/lib/bpf/libbpf.c                        |  94 ++++++++++
>  tools/lib/bpf/libbpf.h                        |  94 ++++++++++
>  tools/lib/bpf/libbpf.map                      |  13 ++
>  tools/lib/bpf/libbpf_internal.h               |   2 +
>  tools/lib/bpf/urdt.bpf.h                      | 103 +++++++++++
>  tools/lib/bpf/urdt.c                          | 145 +++++++++++++++
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  tools/testing/selftests/bpf/prog_tests/urdt.c | 173 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/test_urdt.c | 100 ++++++++++
>  .../selftests/bpf/progs/test_urdt_shared.c    |  59 ++++++
>  12 files changed, 786 insertions(+), 3 deletions(-)
>  create mode 100644 tools/lib/bpf/urdt.bpf.h
>  create mode 100644 tools/lib/bpf/urdt.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/urdt.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_urdt.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_urdt_shared.c
> 

