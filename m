Return-Path: <bpf+bounces-20773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A94B842D38
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 20:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A149C1C248B0
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16D769D1E;
	Tue, 30 Jan 2024 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NoJzvnhT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xDV43xGB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6A47B3FD
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643946; cv=fail; b=e+nwgtNHv59ZBBzZRqAl7S+a7wP06xu9lFJjHGk1gbQNyCAmS1+bp/caLuSo3CXpqZpbQnLkImK/P2M3yfdo0O11K583ARMJuznNmbDuHAUEyz9XfdwYO7GEc46lczpdk6Var22o4GgLuH7WbO3aqCF3EiDI7Lz7G/SgoKKPe64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643946; c=relaxed/simple;
	bh=Pfr7q1wRWVRPnng3ons5QtNkTcBmhkcHreveoI6YMx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=b0By9MjvB87NGi9v30yEsTG8fokgWKKL8PYcQnZOs2HogJlF8sRcSApepY3hQ25gRDbZeXD4pknqINEdgnfG1k1yTgSXm2BzJcCQ/PGjugs+p94b53DVk3krJjDpTnuqYrLpdRIxRHuwygdQRMbJLIdyQwRgvfWyfcfGVC1YpWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NoJzvnhT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xDV43xGB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UHU3G1027201;
	Tue, 30 Jan 2024 19:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=KCiaP9w7WxLQGkl+ErF3x1cLvDBYCZbcGC7sDT85vno=;
 b=NoJzvnhT3tLmExKVsVAhnfgxGmh2FRv/AC/wWxRDWC2PG1CIoVfPGX6PpEgJWUjTsxBz
 U9JZaViBoseNFjMTHd4BKa96qsgDfoBIPb9udiGNLkm69slmtzUyQE0s4g3orjqUs0yl
 UnyExua59LY0RP+DFG4zrY3HCdIYvYwtIgGgNm8HTih8HWBWWXXN15jbHBxKcInRPd3M
 H+JmkbkOAte0/tjC9V+gW4o/hW0rbM7TQkhEl+gLl1UI5/5k4Tg5qqkgGPZ0kviXHrkC
 bzVtown24ghX2t54yPq5yTI3XRszConJz2vUiFGgCFX2WNaYSb0el9EF8L9Q/rTiJOoy /w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2g1ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 19:45:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UIfDGF031462;
	Tue, 30 Jan 2024 19:45:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr97y0bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 19:45:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyPfDVdnthFWZZVBJ8mIJjSVyuJKHSZhVBGSIHeM2uNIIkI6OlRrZ5HmZzcbhfUhkaon0ZAjgWudEWlOlKmOQiedxm5WyxV7bN/g7y3oI20BoiOI0zATFgkwobAY2iXDsJUXFcMe/cBRtGhn02Ub8rOghyHLO6Xuwps2FL70i2fGRTjlnmvcxxoje+7kT82oGgnFg6Sewxie9qzkpQPuBrqkb3E2LUuHj6mwBJZwuAnSlnnu+wEkdfE8GjHHuM5Nno6kcuHK2FZ943SZOMNAaaDudkyIuT6JwJfQK+9M/UnIMZjYKo8kvoJ5zHUlAGE5a5HAhJxvUzG7zuZCNOVetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCiaP9w7WxLQGkl+ErF3x1cLvDBYCZbcGC7sDT85vno=;
 b=ls4Wze8IXswc+ofvXHt/S/Pr3JBdmR3eMe47Gxmns1kkp/q0NksoZUzYiunQOWt1LEuDXJsa58W0jZG5XpmcuhTzvZxCvpA2HoJuQY3/1o78QRkaubV3WrzaWKyW+kUlXqSI0iNyG1vmbSOYoddxsDlcANlrGc7A70wyXbWp8Ova7rNh6R8J47Kt0AVo6RaLo/ZP8zkv308KfKXD13igzmckD/JAzHU5tQujXxFONMxWTFB8Vof2D2WCNuq07C+0qsnqPaU4RLBNex58yFXC4qd8a2Xh81ZowFv+sYycIybRbncCBTHAkOrJNRxG9fXRwa0rVD9hgGnGepnOwXsF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCiaP9w7WxLQGkl+ErF3x1cLvDBYCZbcGC7sDT85vno=;
 b=xDV43xGBFc1LHzlK4QfRHtWPJBnVpqnfGU+ks4e4D++ZUB7zLx5NxlxI5zvIqXvB72K2IUl2RjheNoirvDQ2u8N5dXMSkJ3AiefQb9V9apSA8WboXmlYs/T5Um6o5WOgDddQ0FcUCmJHqywJSMFHgy88HUD76tUJ+hBVt7Jq2oU=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by DS0PR10MB7405.namprd10.prod.outlook.com (2603:10b6:8:15e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 19:45:39 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:45:39 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Cupertino
 Miranda <cupertino.miranda@oracle.com>
Subject: Re: [PATCH bpf-next] bpf: use -Wno-address-of-packed-member when
 building with GCC
In-Reply-To: <CAEf4BzYH5UA8fAZa7LdbjGfSaLMbN5DxUDOe3hp68e55b+eGhA@mail.gmail.com>
	(Andrii Nakryiko's message of "Tue, 30 Jan 2024 11:26:01 -0800")
References: <20240130143220.15258-1-jose.marchesi@oracle.com>
	<CAEf4BzY73K46a=VS-5M45H0abfqt1XCTE9vRnuuGn5rq65ibmg@mail.gmail.com>
	<87o7d2k7c3.fsf@oracle.com>
	<CAEf4BzYH5UA8fAZa7LdbjGfSaLMbN5DxUDOe3hp68e55b+eGhA@mail.gmail.com>
Date: Tue, 30 Jan 2024 20:45:34 +0100
Message-ID: <871q9yk3kx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|DS0PR10MB7405:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b51bab-d968-4eb7-9ff8-08dc21cc0920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mNVb7Mgz884anrLnr0qoEl6mAuetWqytJQose82N8Lm4i7UJyfl4pMv3ZQX2txOoHuG85r0+QxNauMKD3TAVuJ4cPMw9rgvD5HbHAOwNbrxidwo0Rg18hJGAGmZzywC/SbYyRx8p4vLhxsdfdu4A+r1Vfz+6FmSSuM4F6xKlnN2hmUiR96uQgCNwvuzRyPqKMMyBYzBXBRP91It5ts1fErDaMnEF47VPnMsefXPfZhsfxmcFxvXWq7iNt2M6U7c7HrwWMefi8sj0rzXpezAN1N+zGSfnkVJKNcs9bqU8IY/RHanKsIiI5INRC44J0HyWCsUKCJawNuZI/q5SfnFKkO060q9gNBcDglB04O6cgXPngX9inMrTGTnONhcyjDR8LGSR9rFJNxM348+EFk823HQi2NzTrMbUKK5x5ONiWxHy1cChwZ+Db1wR+te3Jculxpn1KnvBrtBZtRgDjNR5Kp16yy3NGgZxgfKicZ/VAn7QTApHXwfejfSnATBC2kJVZPNwipPq8y5eK6/JrtluoSfgtleR29H1W6SeIYGDML3aSskp7ifRGjWHUiiejpWaSK3iZIBaXGlT7+ZjIL02L8/Gsa1pPk+7X5BBPhkvrHXd7vkEPm0/KSfbCSJXCIRh
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2616005)(107886003)(41300700001)(36756003)(26005)(6486002)(6666004)(53546011)(6506007)(83380400001)(6512007)(478600001)(38100700002)(316002)(2906002)(86362001)(8676002)(54906003)(5660300002)(66556008)(6916009)(66946007)(66476007)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aXRKNmNSYk5pc21SWko2bk1TVE5qOGZtZ2kwdWlWU1NXOGI4VXRXN1dIdDF3?=
 =?utf-8?B?ZSt3MitNT1NiT2hZV2NCR0Uwem5uZURxVzQvWmI2TDRhWUN6dittc3hmSFJZ?=
 =?utf-8?B?b0diWGhTYVg5QnNzZHBSeXZLbG1NbW1XL0VrVmx6MHZhUzN4emZUcmpJSFo4?=
 =?utf-8?B?L2FQczNiVnZHU0JXbGgwM2VTNFpGOE9zelUvNm02Z2s2bVVpMHVjU1ZjaVhz?=
 =?utf-8?B?RzlWSGZKMTZSMGk1RHEza2tNRVpvYjk5VGRZakVEN3IrRHNxRS9IcGxqNVB5?=
 =?utf-8?B?SzlhMXcwMkxlc1JMV0tmeGt2L1NZS3BEZkk2NmZ0UXhCVTRjdGVpVUVUTWdS?=
 =?utf-8?B?L1dJN09mY1gyTEFLb3JWVGhwOUt0dTJJK3o3OUs2Mk1td2ZXbTlTckhRSXVa?=
 =?utf-8?B?WHlXazk5U09hREtDb0k5dmJpUUMxdkZCbFVtOXNoeUxyTmYvTForZWFuOEdi?=
 =?utf-8?B?emRWSUhoTUI1U0xPZk10S0c2M0VvNk9YdFl1M1ViNnFGZDJoR1IyZkNRR1pq?=
 =?utf-8?B?enEvN2tMdXJrOEswYkl4TVVSYlB0R2szRitGUmptVjVlZmsyakkrVVhYeUpk?=
 =?utf-8?B?cjBwdXpLRWhEcDRablppR3pzeVQ5b0xXN0tvZ3kwTDRidTAxVVdLQS9kb2hV?=
 =?utf-8?B?VUhObktkWDZqZThITTk3ajM4amFUUVBBN1lBUGxkOEFxUHB5VkxZODNyaUYv?=
 =?utf-8?B?TEpPdStSYjlxdWRRZUQ4L2I4S0s4bzdRVW55UEMrY2lpazhkV3RSK0F3b0l5?=
 =?utf-8?B?SXFJZDNLbnZlYk9HZmJOdStiQ3Jqa0VVakVBaUJjZk1adXp1WUQ0dWQ2R21k?=
 =?utf-8?B?UnpWL0JEbnZvelF1S0YrbUlwRVhuK1U0UGR3SEFwdnhhSklSc0lBaFE4ZHlw?=
 =?utf-8?B?ejdOSGY3R0hPM2ZDTmdhV1dqQ2dodVN4KzcyMWlla3FMRFhOK2QyWE5Yc0Nz?=
 =?utf-8?B?QUpBKzZaZk9heVAwTFZUcmRod0puclA3WDVPV1o1TG1zYkpRdGlOYXF3M0pS?=
 =?utf-8?B?WFRROUdHNzE0K0VuSTZ6bmQyVGJTYWcvS0pjRjVUMzI4VEo4dVBwOU0wWHU0?=
 =?utf-8?B?aHJpRkR4a1BQUTkwc1lWM3ZiK28rd2RJZlFnSUFxMzV3cUJqbWRUZVVCUy93?=
 =?utf-8?B?YXBqV3RFZmhHQlNkeGVDR2RJUVpNRElkRVl2Zk01ZG5JL1o5RGJkbWs4dEl4?=
 =?utf-8?B?U0FEdVVrMlo2NU5HS2daWFRqODZZbEs0R2dZWDkzRXk2YlJSeDNuK2lNRGJp?=
 =?utf-8?B?ZlFLVWpYc0djdTdlZ0JSakhwUzJHWmZVd05ERUt2aFF5ZmgzUkNwYmpKNUZ0?=
 =?utf-8?B?dFh4eWZubm9MWm5QUXBOS0dIbzRmdEN2UzlaTWQwNWVzRU55c3dQa2V1NGtB?=
 =?utf-8?B?Q0VncHV3elVQTmIza004eFZkb09pR0JVYnFZQWlyVDJSUTR1NkNBSmNZeStG?=
 =?utf-8?B?dVhxanYwUFlrMG5lMnVyZG1hbTJTSlRpMUZNdVYwUDVZL1RaUFFHZnZadjN6?=
 =?utf-8?B?Wmp1TktYaXRGWXRyUEg1Tm93THJLSGlsanFkNk15Q0drd2xMMjczK0E1VW1j?=
 =?utf-8?B?b1U4OHZWcERiOXFOYUs5dmdwREUrdjd1YzM3ZFpRaWl2enI4dmgyZUdscUVW?=
 =?utf-8?B?aHA4U3VNeDZldWNWZjQ5UDFGWGVLTjk2RFhxcXlrVjU0UGcwOXk3NlV6V0dl?=
 =?utf-8?B?QjY5bkp4QXpqVjhGbWQ2WHBvWVVBWU1uTGZZbEFBSGMzRzlnRVdDY3FMM0Nk?=
 =?utf-8?B?KzFDMUkwYXVXZlh4TjJ1MGprMWJyMCtxSWN0TjdIMzFuWmp6dFpaaTRKMEZK?=
 =?utf-8?B?c1V2VCs3MmIvOWpqMTdjMjdQTmdXVTdVdmZmN1FIZ2V6ODZsQVgrcFJnVVAv?=
 =?utf-8?B?eXRVYU85MU9wYnNvTzZvNjV3cjZJaGdiU256cjh0MS9XMVRDWmlwb0RKNThK?=
 =?utf-8?B?dElVNEpWSWVZZVFEWjVLUVk4dDU1Njk4OFEwWFRhaTJ4NUprZ3VFRFo1RWVw?=
 =?utf-8?B?RDZNVVM2T2NHenFDemowS3I2TnZUU0hrdVgzdFhpandXVzVIT0U5bTNHeXd1?=
 =?utf-8?B?SzNqWDV3VlM5UVhxeWY5ak9UbEdBNkRLTWV5YktNSjRMNWpzbnZHMzFNQ29N?=
 =?utf-8?B?VHZaRUFKMm50eGlqTHB2VkVKSTFxSWNReGdDbFpRUUwzY1hiN25lRDE4TTFS?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tmW04yga6uOLjx/cHNnVN0rO6N/6R2Wrez8Cmrgu3EhXydCVUuE+hLh3acIOjSGLSilz0hzObJio02X9CEiUk6fgBgtPgpprX/PKRaK/dc3lb6nj9AuU1r4xNXFBkgO9XoshwpxY8uDd6d+PzV+f1H4Mrmx20k6L0SWiF8IJije3QusJEKkDTmRRMNiHGI9z2PSLGqKzhmGR5c/XcBBalE3Dc4M3f0REQ/vMeStb7ZBL2xRC4bFuTowdIAS692XZCajE5XIm5n3TCSdO5m6twiup/nPWEDYS1nqjFcHpk8Afe+QURWZNKny2XUaamB7/Cg/3M61K9yIKMSpt/IgzgD/nXMo2lHVvt//SUCQpb95fKMopI3d4DZre4rhOZifEYowAnb1VJjET97TBu+j3kCzvYavubFQXlGGRyeUDvyyj18ggOnfLVcNwaWADgAiaN67CY23+c8MqxQD2cMeepr14KwWKvHySBrnE8/s2oq3SewVlHB3vMrFYvANtwVQCiYTQE0RFTazQvv+xiF3Npw8H73yRD+S7VuezPhKlUJBV1BsVgzO1lYl8BeHM5/hEnIl4nSNBrbEOGqR7Zxuot+lenB+X3yM93/4lN5SqPb8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b51bab-d968-4eb7-9ff8-08dc21cc0920
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:45:39.2519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BA8GbFC8e5yiaJ+Vw0UDziWBe+zmcr/O9V65exCScwNriLKmQiCNBbI2rzU/KcPNvpHX2DwP/JKWYknrdCSwePbpAN2BnEtJ6h2J8MlJlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7405
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_09,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300147
X-Proofpoint-GUID: uv9c8RfVTcmQW0lRrIUovC1jW4T7dUUC
X-Proofpoint-ORIG-GUID: uv9c8RfVTcmQW0lRrIUovC1jW4T7dUUC

> On Tue, Jan 30, 2024 at 10:24=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Tue, Jan 30, 2024 at 6:32=E2=80=AFAM Jose E. Marchesi
>> > <jose.marchesi@oracle.com> wrote:
>> >>
>> >> GCC implements the -Wno-address-of-packed-member warning, which is
>> >> enabled by -Wall, that warns about taking the address of a packed
>> >> struct field when it can lead to an "unaligned" address.  Clang
>> >> doesn't support this warning.
>> >>
>> >> This triggers the following errors (-Werror) when building three
>> >> particular BPF selftests with GCC:
>> >>
>> >>   progs/test_cls_redirect.c
>> >>   986 |         if (ipv4_is_fragment((void *)&encap->ip)) {
>> >>   progs/test_cls_redirect_dynptr.c
>> >>   410 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>> >>   progs/test_cls_redirect.c
>> >>   521 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>> >>   progs/test_tc_tunnel.c
>> >>    232 |         set_ipv4_csum((void *)&h_outer.ip);
>> >>
>> >> These warnings do not signal any real problem in the tests as far as =
I
>> >> can see.
>> >>
>> >> This patch modifies selftests/bpf/Makefile to build these particular
>> >> selftests with -Wno-address-of-packed-member when bpf-gcc is used.
>> >> Note that we cannot use diagnostics pragmas (which are generally
>> >> preferred if I understood properly in a recent BPF office hours)
>> >> because Clang doesn't support these warnings.
>> >>
>> >> Tested in bpf-next master.
>> >> No regressions.
>> >>
>> >> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> >> Cc: Yonghong Song <yhs@meta.com>
>> >> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> >> Cc: David Faust <david.faust@oracle.com>
>> >> Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
>> >> ---
>> >>  tools/testing/selftests/bpf/Makefile | 6 ++++++
>> >>  1 file changed, 6 insertions(+)
>> >>
>> >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/sel=
ftests/bpf/Makefile
>> >> index 1a3654bcb5dd..036473060bae 100644
>> >> --- a/tools/testing/selftests/bpf/Makefile
>> >> +++ b/tools/testing/selftests/bpf/Makefile
>> >> @@ -73,6 +73,12 @@ progs/btf_dump_test_case_namespacing.c-CFLAGS :=3D=
 -Wno-error
>> >>  progs/btf_dump_test_case_packing.c-CFLAGS :=3D -Wno-error
>> >>  progs/btf_dump_test_case_padding.c-CFLAGS :=3D -Wno-error
>> >>  progs/btf_dump_test_case_syntax.c-CFLAGS :=3D -Wno-error
>> >> +
>> >> +# The following selftests take the address of packed struct fields i=
n
>> >> +# a way that can lead to unaligned addresses.  GCC warns about this.
>> >> +progs/test_cls_redirect.c-CFLAGS :=3D -Wno-address-of-packed-member
>> >> +progs/test_cls_redirect_dynpr.c-CFLAGS :=3D -Wno-address-of-packed-m=
ember
>> >> +progs/test_tc_tunnel.c-CFLAGS :=3D -Wno-address-of-packed-member
>> >
>> > Why Makefile additions like these are preferable to just using #pragma
>> > in corresponding .c file? I understand there is no #pragma equivalent
>> > of -Wno-error, but these diagnostics do have #pragma equivalent,
>> > right?
>>
>> Not with this particular one, because Clang doesn't support
>> -W[no-]address-of-packed-member so it would lead to compilation error.
>>
>> Hence:
>>
>> >> Note that we cannot use diagnostics pragmas (which are generally
>> >> preferred if I understood properly in a recent BPF office hours)
>> >> because Clang doesn't support these warnings.
>>
>
> But can't we have
>
> #ifdef __gcc__
> #pragma ...
> #endif
>
>
> My main point of contention is that having those pragmas
> (conditionally) added in respective .c files makes it easier to be
> aware of them. While keeping them in Makefile is very opaque and we'll
> definitely forget about them, the only way to even notice them would
> be to run make V=3D1 and read very-very carefully.

Oh yeah that's certainly possible.  Since clang likes to pretend it is
other compilers, the guard would be:

#if !__clang__
#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
#endif

Will send an updated patch.

FWIW I agree in that per-file pragmas are way better than Makefile
flags.

>
>
>> >
>> >>  endif
>> >>
>> >>  ifneq ($(CLANG_CPUV4),)
>> >> --
>> >> 2.30.2
>> >>
>> >>

