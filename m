Return-Path: <bpf+bounces-20625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D818412B2
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 19:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5507A282D74
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3313C15AADF;
	Mon, 29 Jan 2024 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pd4NugUa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HUSeIfMF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662715698A
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553818; cv=fail; b=OJjrog9yaiySvqkR5bsem7bpDmUomQNwiPwLLy6Z73z2HlUZJugKD5bHnN0n7RdnLyHDn1ETFi7RVudJ3Jql7Kfp1vCMcNaTyY/ox7KrDQECBMLvRh50bwC/EwijcE9xqlgNMy4k5dy9f5fFo1VjSPX5L7YqyGwB6n7I6BArQNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553818; c=relaxed/simple;
	bh=j4HVn6bqlRMc1xNZeqBhl7MysJXQEHu6B29LXFZLTu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=CGC01/4wxij+X3K6xMEuH7BSk62L5ii+IveKs1gU34+8wESVy5HSw9Ezg/maitavJL1f5ZHKr8Cx8vsvfYF0DUY2inm2nKWczzr77PQjrLerADF6JrTN5kKdmYp2RGVfgfBOnMYGqXND3Kr602+BRnSKPYqiSsoMiuahA1pRwic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pd4NugUa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HUSeIfMF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TGnBPC001211;
	Mon, 29 Jan 2024 18:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=iaYZyPmDGxnfd8PgDW1RpOEFXKgCDX/JdZ0WadDBZzo=;
 b=Pd4NugUajb8/hqywS851Wr1QwupQJjZDQLq9SGGIuMadD7FhurPb7nS87DQikJ16/mtd
 X3yksejPGPw0Hn9rCoEsD+Ai0HI9NsaeVehOuyRkuhU6m8Iqi+W6FUtVRRVEw03ZxNKR
 zBWzZgr52Z+glSGjDC/3o2TFeBZ7B5wWP0rDZ7q4rBjL9Hrq/R7c7VyOFZJzpzEX/l8M
 svZGSwTWxLKMQ+3DdhQPFU0eQMpg9oxlU2HUQSlC6j9OWtzUdi6g5tQC/W5HLl1Kxt1w
 coad08XIKm6WTRwf3maLeOm3JqRBaWmnXeSBYvFRpnatoQF8WKjJd2QnT50HL7n8ltJG 3Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsqavn48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 18:43:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40THMpd1014602;
	Mon, 29 Jan 2024 18:43:28 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9ca3fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 18:43:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkC4qq1V/wlqXVbhVAmfsgn51tnRgFj9S3dmpFmn/acr3ZYqHMPB+/9z/pnP3gWGDJzhMSUpksqFuKnIvlBnGCJZUCanyoU46QScFYQ1o8RP6mvhMSJk0zeUjD7PEZYkAWrtqrhut3dUn8odZoJct4bteDXsB5z1mxIMXuYokFKGI274nWEzF2xOq9WYQAeccLyti+NEeHmxpMc01u+Xzy5r4XiueyhpkUjY2OMREO/oqLMTDJn4knlfwJeWkyMjrlcI3nZ6zCcFIy0+qoj+n6CkFXlT/bHpt92LMQK8/xy3BQk4u1kmvixx0AzIC3bxHumk3YjwkScp0Ping2DtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaYZyPmDGxnfd8PgDW1RpOEFXKgCDX/JdZ0WadDBZzo=;
 b=PdI+NIo7kJ7ANAzNBYuQkdKlAY2l0n/83LKpLsuxqbPy/DWvHV80QkN1xzLIqjnTU3dc9ydXMtqb6Hnz8tBllC81xthcz5BKlvApIzFUFNArOCUrqv0aRN/ruYquUknfWW9ekV4ea3DWFnuwsl2Edd3Bz3c8D8dZmfPCsBNXGcpGCIfhJPdmk5OqxSTJM9uMY/S6lsBb/4ooIzkxAyU9b56WFoisqKwJzECdoElBjQLmz58WqW2TAAwm4eo2PizCDGKQC+g6jlH9sFm5GgcUr0MmQqI391Ce4nzsId/+P+Wj9J8upklhZpTCOkdmRHdy3Vb7p/ZhmaHSb1580vHMoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaYZyPmDGxnfd8PgDW1RpOEFXKgCDX/JdZ0WadDBZzo=;
 b=HUSeIfMFL4FuXb96nF/LNsIMAJ04UxgB3B1nHQKZq1wGt5cTO9Yw7SksLrdzAffadFTLsA5wSpY1JZLNtyg03AQV4KlBsYP7STNvbNulySFoWanYtVIDs+zLu6bWknWFLdpCRpC/R9kPvZa4lwLtmqjbYB+jUCxmqTW1PuOS2OE=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Mon, 29 Jan
 2024 18:43:25 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 18:43:25 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        david.faust@oracle.com, cupertino.miranda@oracle.com,
        Yonghong Song
 <yhs@meta.com>
Subject: Re: BPF selftests and strict aliasing
In-Reply-To: <1b6daace-3c82-47c5-9b75-66051f8e3933@linux.dev> (Yonghong Song's
	message of "Mon, 29 Jan 2024 10:16:56 -0800")
References: <87plxmsg37.fsf@oracle.com>
	<b1906297-d784-479b-b2f3-07ab84ae99c1@linux.dev>
	<87a5opskz0.fsf@oracle.com>
	<04efa2a3-ca81-42c3-883f-5b91917f2bde@linux.dev>
	<6819204566bfae73c140938920eeb389d27abad8.camel@gmail.com>
	<87sf2gnk8w.fsf@oracle.com>
	<1b6daace-3c82-47c5-9b75-66051f8e3933@linux.dev>
Date: Mon, 29 Jan 2024 19:43:21 +0100
Message-ID: <875xzcnfp2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM9P192CA0023.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::28) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f8e7ca-94a7-41dc-51eb-08dc20fa2d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LUNCNpwYgq2WyPtuUxkMCvoWHkhK/XLCBLd+LbUJZMSPkDkHNPE5a8AK/XnheMrOX1av0frTt8lKqAz7I7RMnat5pML/yRAiOy56uI9uS1ZxetoSwxUQ83uCbSo1fyAaDSQLNWnQ0Ze2PHgXVnO/wrU8Ry+XnI5wNjMUKbwiABTWlVlbYRnlnBgsTUEJSFg+RWYmTzkdRYDgWqdhhyjf9yzd3ROm61C2Ic/LXKXE5VcsyiBXU3Friy78kV3+yBUuOu1wBZe2w09U2A1JHY06fgkBI8JjH1mUs5YX2E+ey3hYRjemxXJH24S1HrfeXsCS1wyM2RjUHKTcq/ZJErtQLJkSibLjjP1Ut4pKYlGbPujFiGV5Q+TYMd4yf4YodMjJKNLBP2rb523w0vsdpQd+hQu9QzixlEBgMqYh8rztgXbMKz8ET8HVOCYadxRk70TavPwQBKuWwhMtV+NvRzA+mbsWmT0wy6wnx58OjZTFSyIEobtalH59VdiHktAMDf3kTQ2og2qg0Uo0XK9YrdJV4/TFK2a+VO0SsZFPuWLgdAQwhLnMHWF81Kxh5JKhD/5htziHhmf3bf8U5gFQ2HS94rlQaJMcuvWL95l3VfUZe3hOTGoRKMuMDb4SotL16C5c
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230273577357003)(230922051799003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(53546011)(6666004)(6506007)(6512007)(66946007)(478600001)(316002)(38100700002)(5660300002)(4326008)(8676002)(41300700001)(8936002)(2616005)(6486002)(2906002)(66476007)(54906003)(6916009)(66556008)(36756003)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ejFPbkxvZVVHZm8zY1owWHUxdGFTSzJBbE41Q21KT1BjUGxidkcyQkR6Mmxx?=
 =?utf-8?B?Z0xBdXhqV2tKbytkWFRpc3l6c2dHT3ZGRmR4bnN6aCtlRzJxZkVQb0YxNERi?=
 =?utf-8?B?M2VUVzQ2Uy9oZGVxcnAxMlpYbk5aU1NiNFRWc3ovMzJ2RGJDbTdFWjBTUjI0?=
 =?utf-8?B?TVcxTEN1OVFwM2dkMTE3TWlvNGFhRGxQZ3kwVTR3S3RtcnRtbXJTcVRvYUJU?=
 =?utf-8?B?ZnJkMHNqdDA1eVNZZFk5NkdlTWFNQWhER2VTd3VDSHpVenRvRzRnQzZxVmg3?=
 =?utf-8?B?empNc2VJanNyUUNENVR6NmE4dzl0TW1TSWtzTGtyVWhNRHVBTUdHTG56Ujdl?=
 =?utf-8?B?azMweUFCZ1l2cjBGeEZvM1VybFRJalpJeVNiRXlOeVF6WmlMdnl5SE5VOWJ0?=
 =?utf-8?B?VVJ0cGU1WDFHUzZuRWRPbHlpYm5mb3NKelpENld2Z0tlWnNEbm1FS1RLS0wr?=
 =?utf-8?B?Y3pkRDQ5NjZCTktDN1UvNVI3d0xJV1VzZ1doeHNQK2J5dEwwZ3hxN1pvT2lz?=
 =?utf-8?B?NmdKbDNFYlRESGQ2MjVTL0Y4T3UrbEtYOEJwdDNFVldmVFBlOVRFbm5jV3g4?=
 =?utf-8?B?aHY4b2MyMEx3b3U4MWtxeGs2bVVteERHM1VoNkpDeFF3TkFFQWQxclpOK21R?=
 =?utf-8?B?b2ZBWG5mQVFvejRzZmxDT0o1aVhiYXhXcEM5c1NWbXd4cXJZSjFBZHNoRmY1?=
 =?utf-8?B?TEk4eFlQL2NwSTh0RlJ2a2gyeTdEOENWc0R0SjUrZ3Z4WnRGZ2ltM1duc2R6?=
 =?utf-8?B?WE1XQ2dzV1FxdUUvaTRMZXQxVTFCSnlscURBM2hvMFBYVGJqWEhKVjZhWmNJ?=
 =?utf-8?B?QWNxekFTQmtITjZvOG9FY2E4TXNUM2xqcG81NGdvdUhHa05LOGtWWk40Wktr?=
 =?utf-8?B?VGVoSFdrQkZoTXZNN0hWdVJzZmZUZGtaM1djK3ltQ2hkOVIxU2lUV2RoYTgz?=
 =?utf-8?B?WEZXRVFWcmVHU0dnOGlTbmlKREdQd1V5dWNUZ05rbXZlN2FUMXNhMmQvSHQ1?=
 =?utf-8?B?T08yaTJxWTZtVEFNOVdUUVNnbk9YOGdKdzlFVVRQbDRxWWp6Qnh6aXVJWUc5?=
 =?utf-8?B?QTYzSk5Ma01XdVAyOEorUTlvd0xhZVlrMmJWSmd6TkFuK2tYTlhvek5TRlF3?=
 =?utf-8?B?QkszaU10Yk1McXVTL0NmRVVhVE1RM2liT2RZRUNVUkZmZEtocDNkcTR2aitS?=
 =?utf-8?B?TmtQWEVFVFl2UUhXbzlZT1ZlQVNBY0l2enJSMFRCZGkxNnpweDBYSlVUb1Vr?=
 =?utf-8?B?eEJiaGVWTkcvTHRZaFBSRVRzLytrNGw0WWpJSTVENmJTUG4xWWt0dGFMSDJj?=
 =?utf-8?B?eGR2Y1h4V0lXQkN3V3RRNXdMWUpVTVNHZkpKTXlGcHlJSC9jQVd2dmhQYS9y?=
 =?utf-8?B?WDlWYks4WlFqR0lORlBFUk9VZ2djSkRIY0RoL2tqT0VrOG9peU04U1NYRmJN?=
 =?utf-8?B?Szd6NW41dFZrNEJzVlRBa1NhQlNzeXFEenZWMEZrYi9FdUsxYVk3Zmo2RVZX?=
 =?utf-8?B?V3NNVk52dGhlSkdqZWNJZlMzT1gzMFZDa3NJUkhFamJzbFNsWG1oYUFmNFgz?=
 =?utf-8?B?QXc5c1QvRXhmeHRMdmdaSjQyOHF3U0pHRzFDeE1sRmNhekV5MFJJMW9HZnhv?=
 =?utf-8?B?WmpVaHU3bXF3d25tMTBmb3JtN1MvQ3VicXBzUFJhbDRGUWUzNlZWTFNjZC9F?=
 =?utf-8?B?OEhsVTdySlIxNUs4ZEYzajJQc0llVzBMOUpLcEZzd2EwWWFFSmlBa2d1QVBu?=
 =?utf-8?B?YkRZYjh2N3YwMmRqM3J1dmVTUHpuNXRnVlJtSmN5MnZlaEJhOEoyRUVxVXBy?=
 =?utf-8?B?ZjBWcTY4VVhtMUg3YUtJb2hmZno1SmRCYUlnZlhTU1dSRUhHTkZGSmxLSkJt?=
 =?utf-8?B?SGpyWTdGN2Q4UGtCTzJLVEZLb1JpT083VURJNFlVQlRLU01hU1ZUTEpiS2lZ?=
 =?utf-8?B?WTRTS2NDSkZydVcvbG1DZStIK3RJa1dOTFBCVm1VMTZtQzRIWjk3KzRBbmtI?=
 =?utf-8?B?M3BNd2o1VmdqQ29HRTNZQ3d0THZKRzRYZElYMkt4ODAra21RVE5DVUVkdTBz?=
 =?utf-8?B?Mk5tU1FUUUhxREVhbzBxcDJ5alRCRm5ySTYrTnVVcmJjMUJpUmVJM3dVVysx?=
 =?utf-8?B?V3MwNm4zNHp2eFkxSlY1ZVhaNCtjaThNM00ybUQwdS9qMU1pbmJxbkVQVTht?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wLOimjhIocLk7Hd4Ua1M6KhKSTZi8RWAo2MxkBCKu9SblNT9kWxRQyiY7U3M0JLua/gSFpxrN1EK0Ad42r7CptWiS7UPQ60e79+FvzH7nzxXS8Z+oGFoKcg/fd0DnbWDSCDAJH4cyKNxk4yLbwgtok/KRT639BHPOqajL23cdblkqpSLNseefJ3RCe5L35wlw0eNmhb6Um4UeUFLXWGnGkiBfL12In8S3J6EN7alY1TTcYLWEtaovq2wK4Cqou6yyxA+FFj8Lyn0VkCCDYCYHWfXPGi6i0rdKNKWg+06OWQQLDlThNz+ILvGS8mrYv1Fr/2TvdOWnDh+ejHufXjAIXzipvNqQBJxQjZLFBER6g+jAFn7KG28NJagFbt22Io31I6cVyzyO8JHhc46jHUvnl5RpArguVJ17UCbZgEAFRPqVGtVgvtPqSuDxBldTrdukMsuwT2LBpMGHdOyUX0t52+1T6My3QpeXD8gskk5jUeaGOJootRKvkzBpo6yiQOn6Gt4N+7muuCNQozKhqx334+Pz+4SjmKx3HbVpLGAgLiprMc9kJYuzLrVbQIHiatmZYfulZdxB/17Cgx/CzY6cVMWBfiDsL6PPiQ27xmVZmA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f8e7ca-94a7-41dc-51eb-08dc20fa2d17
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 18:43:25.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBVj7jDJaRQTZftPPm1c4YRdjx1p9zpCdTrsYCtQ5SFZx/tJjWEQ9/YA2Ij//94Wvz2nBdCv3jUDe87FXG17xplIE7N65Qg0Kc/SN+kLy98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_12,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290139
X-Proofpoint-GUID: j7SNnmCfyv5dF2j4EWH0agz__KoZa4GR
X-Proofpoint-ORIG-GUID: j7SNnmCfyv5dF2j4EWH0agz__KoZa4GR


> On 1/29/24 9:05 AM, Jose E. Marchesi wrote:
>>> On Sun, 2024-01-28 at 21:33 -0800, Yonghong Song wrote:
>>> [...]
>>>> I tried below example with the above prog/dynptr_fail.c case with gcc =
11.4
>>>> for native x86 target and didn't trigger the warning. Maybe this requi=
res
>>>> latest gcc? Or test C file is not sufficient enough to trigger the war=
ning?
>>>>
>>>> [~/tmp1]$ cat t.c
>>>> struct t {
>>>>   =C2=A0 char a;
>>>>   =C2=A0 short b;
>>>>   =C2=A0 int c;
>>>> };
>>>> void init(struct t *);
>>>> long foo() {
>>>>   =C2=A0 struct t dummy;
>>>>   =C2=A0 init(&dummy);
>>>>   =C2=A0 return *(int *)&dummy;
>>>> }
>>>> [~/tmp1]$ gcc -Wall -Werror -O2 -g -Wno-compare-distinct-pointer-types=
 -c t.c
>>>> [~/tmp1]$ gcc --version
>>>> gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2)
>>> I managed to trigger this warning for gcc 13.2.1:
>>>
>>>      $ gcc -fstrict-aliasing -Wstrict-aliasing=3D1 -c test-punning.c -o=
 /dev/null
>>>      test-punning.c: In function =E2=80=98foo=E2=80=99:
>>>      test-punning.c:10:19: warning: dereferencing type-punned pointer m=
ight break strict-aliasing rules [-Wstrict-aliasing]
>>>         10 |    return *(int *)&dummy;
>>>            |                   ^~~~~~
>>>      Note the -Wstrict-aliasing=3D1 option, w/o =3D1 suffix it does not
>>> trigger.
>>>
>>> Grepping words "strict-aliasing", "strictaliasing", "strict_aliasing"
>>> through clang code-base does not show any diagnostic related tests or
>>> detection logic. It appears to me clang does not warn about strict
>>> aliasing violations at all and -Wstrict-aliasing=3D* are just stubs at
>>> the moment.
>> Detecting strict aliasing violations can only be done by looking at
>> particular code constructions (casts immediately followed by
>> dereferencing for example) so GCC provides these three levels: 1, 2, and
>> 3 which is the default.  Level 1 can result in false positives (hence
>> the "might" in the warning message) while higher levels have less false
>> positives, but will likely miss lots of real positives.
>
> clang has not implemented this yet.
>
>>
>> In this case, it seems to me clear that a pointer to int does not alias
>> a pointer to struct t.  So I would say, in this little program
>> strict-aliasing=3D1 catches a real positive, while strict-aliasing=3D3
>> misses a real positive.
>
> This make sense. But could you pose the exact bpf compilation command
> line which triggers strict-aliasing warning? Does the compiler command
> line have -fstrict-aliasing?

In GCC -fstrict-aliasing is activated at levels -O2, -O3 and -Os.  From
a quick look at Clang.cpp, I _think_ it generally assumes strict
aliasing when optimizing except when it tries to be compatible with
Visual Studio C++ compilers (that clang-cl driver thingie.)

From the GCC manual:

'-fstrict-aliasing'
     Allow the compiler to assume the strictest aliasing rules
     applicable to the language being compiled.  For C (and C++), this
     activates optimizations based on the type of expressions.  In
     particular, an object of one type is assumed never to reside at the
     same address as an object of a different type, unless the types are
     almost the same.  For example, an 'unsigned int' can alias an
     'int', but not a 'void*' or a 'double'.  A character type may alias
     any other type.

     Pay special attention to code like this:
          union a_union {
            int i;
            double d;
          };

          int f() {
            union a_union t;
            t.d =3D 3.0;
            return t.i;
          }
     The practice of reading from a different union member than the one
     most recently written to (called "type-punning") is common.  Even
     with '-fstrict-aliasing', type-punning is allowed, provided the
     memory is accessed through the union type.  So, the code above
     works as expected.  *Note Structures unions enumerations and
     bit-fields implementation::.  However, this code might not:
          int f() {
            union a_union t;
            int* ip;
            t.d =3D 3.0;
            ip =3D &t.i;
            return *ip;
          }

     Similarly, access by taking the address, casting the resulting
     pointer and dereferencing the result has undefined behavior, even
     if the cast uses a union type, e.g.:
          int f() {
            double d =3D 3.0;
            return ((union a_union *) &d)->i;
          }

     The '-fstrict-aliasing' option is enabled at levels '-O2', '-O3',
     '-Os'.

