Return-Path: <bpf+bounces-20634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B78841551
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 23:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678D9285AD5
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 22:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB5159593;
	Mon, 29 Jan 2024 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PB3+6weV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TUefQOXo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09C159584
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565598; cv=fail; b=F1rBSxMyTHE50ArZhDFDssnvwhSF0GQGza2BgpbDD/qTH1IEfYVpnxqSsh/T4BwVnt96X8147FIK75wRpUVmuA6i1ibejUSwHZqwvxYw9xGgFkhgQ4pgiiWsmqSfyKYGrRsUsSRPrqbdflihVnjqFKEIlg0VwXileh63AC0lg+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565598; c=relaxed/simple;
	bh=AyJKlm+GwDpc/HHGlGaJvDrEx8fEoNVnRlNsVW0nbv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=EJgroXoD3ZfHuIm1iFs/WYSdFLvQtpGGxuSnyq1xWk+Bj7k869CIV6jJ0lZXcXFgbEVFLqYkXB/GBqpotZSmuYXhY5uOovmWb6anCJyJLRft7zq4QkgeHu+sMqIpJoV9Tap2kzTQdwwQ/j71AswyodRHSuOxoXsFICmwvXgj16Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PB3+6weV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TUefQOXo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJi03T029556;
	Mon, 29 Jan 2024 21:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=m4EWl0VNFfwhYHHrq7OI9jCU9Kusgmp/trpb87T39jk=;
 b=PB3+6weV163f8D7uZO2H6RZblgX/HCkseqm7buFder441AyoX0BYKUqyw3r9YUpN2Yi9
 GL+H7w1TKHalFCn4Cb5KmUfAnpy+pAztIxk4+PdJrnWfQhruf8RTd4wDZFekZIZYdJUT
 NrsWDRyqi2F296zVdgKm6j5betTgJBZT6bzozCnFaM2aR0iVhjXye61hgE8prrBF3pMr
 yI798hWZiuYy1F9OqwY180yDfHe1JVHGAlRoJECaHkk267WbEfXaSFUvIWERS8ZdO4X1
 Qs4mFvhVfV3W9Yb5KF469Y7TzwPFMzRdtRHSoQN7+SYR5OLbEMYUeYKQ84qhC/EwkMgW Wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8ed221-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 21:59:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TKeJx7014683;
	Mon, 29 Jan 2024 21:59:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9chb3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 21:59:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMs3pk3Jt0UK2osx+dOOZ7clMsPBocv56mGFpG7ymxbd6Xx4N7WcdrtS48HRVQJTcrvnuqaKRwiK07oheB+aoWMn+KfcorerXtFMkrv0OpezLcbMFOqBfuB5MqCuxRNMW4CdAUDuKvRiZjk2V63feYE1XlZSV6DOL4BUY/Hm8Jd7mWLK4xNqV2srZiBTd+pX/uRYKBJnrGz93gNX4cvn2FAA3EjcdBmaGV8/Mzs22SQ6OvpsbypznN/mrsWO7tRI+w3+JkGfAtcSaEJBa0rDr/MyS1rUFwFRkhmFwkreNl1s8BOz2PKfNGhk8R63pekEvE7gmkiUmYoohUOsevQnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4EWl0VNFfwhYHHrq7OI9jCU9Kusgmp/trpb87T39jk=;
 b=ODVXODhu+KHBJewRC49Ri98HEZCbx2XZBar2n12NaZVK+tf5okNKUt9al+oz3I+ThQ56SpxPD36VyVe64fThQo+iidc/7OIaT94SSMEyar7VntI5QLQXSv6NmKt1MyLo2+Jkt4YgHbvmco2Ui73OZ7LLgb58+tzENeQzXA4EH6LAI/yXVn75OkYdbnppgCecsntRMY28UnIxlBysaCkW/N1Xf38EvBwE1cyBtO2kMZUeJhBQvImga8XrlghoaPInlnYbYLo2G29EMYpZt4AJ+2Mdy+EW29TwegS80pdI8F59c+Cveri+6d/H0mR87pSDKIs8OAiSlBpJvsT2R0UVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4EWl0VNFfwhYHHrq7OI9jCU9Kusgmp/trpb87T39jk=;
 b=TUefQOXoLE6SK4GVVVYVzHfw76gDxFw4uyNxKuaQxjku7NXXe0zzuBXKPfrymTLYIa3cBn2V1JSmGMUDkfeWTKb8aHXpevwkPGreYpPUmICh1GQLL06ltOi3gvTmFTjCdINA4i8HI6nDdLaggTOHsX1LUEtbIae6aTnc6QEF1p0=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 21:59:48 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 21:59:48 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        david.faust@oracle.com, cupertino.miranda@oracle.com,
        Yonghong Song
 <yhs@meta.com>
Subject: Re: BPF selftests and strict aliasing
In-Reply-To: <4653f596-ee27-417d-a590-5fdbd9ffc781@linux.dev> (Yonghong Song's
	message of "Mon, 29 Jan 2024 13:48:42 -0800")
References: <87plxmsg37.fsf@oracle.com>
	<b1906297-d784-479b-b2f3-07ab84ae99c1@linux.dev>
	<87a5opskz0.fsf@oracle.com>
	<04efa2a3-ca81-42c3-883f-5b91917f2bde@linux.dev>
	<6819204566bfae73c140938920eeb389d27abad8.camel@gmail.com>
	<87sf2gnk8w.fsf@oracle.com>
	<1b6daace-3c82-47c5-9b75-66051f8e3933@linux.dev>
	<875xzcnfp2.fsf@oracle.com>
	<4653f596-ee27-417d-a590-5fdbd9ffc781@linux.dev>
Date: Mon, 29 Jan 2024 22:59:45 +0100
Message-ID: <871q9zn6lq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0446.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::26) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 8421558a-c0b5-467c-6ae2-08dc21159cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SgsBX6+97NQnoavOHh+Xff7xhh4Y6fU2JcUEgoNXNYeQs4q3nJX5UD749y15b0N86+1Vg+9iQjmAHoBQdlTfEPLzfHYFZeK7kLS20gweqJhK7ICyy5M+43wUCJcxbUtqpda8mEXhoSEH0UgCTIxDJzJ3utAr4UUFLZyc60jnIojbLWLZHCvn3P8jXvggS32fcNjFhEPoH77Yg/rFtGWmTDfReP3dwJ5yLZ9Kko0MRHh4M8WNEHMaNwYRpAEKht3vvtUkGgKcDNZszfY1Hsb3qWD8eW/7KK7UueEz2WIfsYbEvlMmBnNe2pONFA16eaP1o/7LiXnuMUBau5vTdzD/gGwHMKqs8Yu9LIyaBTC218+rTkFFJuakwIQFhpeXrPGkpt0qOu8GROSbwgUS5TH2kQDawMfIN+O59P6JftowQMVZtaz+OZcCESevr1yQZ0LOriF+mJx1p0W4M6MOXHD/fslqq3DioqRJE/CW491mEusrBWPoaN0cV3str6FNxOMs8e2qtXPXP6F73kvbUAvF+V5FTlA1Aecq2uR+V52lnOiDL9WA0gIelEoprKQGzLmaKrqkmxOyC8mqDS8MWSN/YPH2WGSSmeokd6hsvZ7qIJunA10kCXiLdfkhEVHN2ckn
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230173577357003)(230922051799003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(86362001)(66946007)(66556008)(6486002)(66476007)(6916009)(316002)(478600001)(54906003)(38100700002)(2616005)(6506007)(53546011)(8676002)(6666004)(5660300002)(8936002)(4326008)(26005)(83380400001)(6512007)(36756003)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N1MrSXA1Q25ac0lLMGFKbU1heVZ4NXRuOEx1Q2daUTEwWnNUZE9URy90QzIy?=
 =?utf-8?B?V2NpS0JOVmhCRVVOT1QzZkJBVDlOSGZ4cjMwWUxLODJ6ZnZuWVZCME9sN1NH?=
 =?utf-8?B?aEpOV0JCVmZnVzFndDZselAxcERFWk5pZXJSdVB6YVU4VUMyTVFrK2tXSnJX?=
 =?utf-8?B?aVRPVWo0WitkYVp1Njl3Q3l1M2cxYkFzNG1Cc2lORHNkOEJ5b3d1bGI0c3FF?=
 =?utf-8?B?RlljcGhvNFBEMXhwWGJBWGtEL2VlTUhDNFpiUVVzbFk1akt0NUtZVis0Yitx?=
 =?utf-8?B?dWo5ZUkyeDB1akVFeTZKTjhZSWs0S1hDbSsxR0dmelQ0aXFHRXZ5SUJ0SFpX?=
 =?utf-8?B?Yjd6OG12VlJlcXVXMzJMaEFUV24yL3Rhb2FQL0VoL0dBTDM1bHVkakJ6cmZq?=
 =?utf-8?B?VHU1UlhJMjlhSWFYd3hsamhTeTJaR1hicU1TQytxdmxFd3p6c3VqTEk2bllF?=
 =?utf-8?B?NXlhdWlZOVRCNjBpV2tzV2owb3ViSDJVUDVadmNqVG9aRzRIRnlsZktwRkN6?=
 =?utf-8?B?UVQzUVJJZ1JjS284T2VjQmxUeWoyVkhydDNGdXZLanRSazczZDQrUmpXcmU4?=
 =?utf-8?B?aVhZSzJNQTcralpmenh2Mi91bFNFR1JZMzc2bk1sSlltZFdKWWFSMXdCdGFj?=
 =?utf-8?B?QkZEWWhEK0FFaEt2bFg4VlJ5dytSY1ZTU0xucjE4R2JXT29pK0s2NXNiUWtv?=
 =?utf-8?B?Z0RzOThYOHk5YlBqSjl0VEdZWUc3NVhOZjQzaWI3Vm9mNUZMc1FaUW1tS0lU?=
 =?utf-8?B?QmJzdTF0a2luSWJJSmFlZEp6VWR5OG14TjYyMmtGaC9nZEh2KzZ6dnhEczFD?=
 =?utf-8?B?QUJqcTFLeE4vMWxHVnhZS3VadTc5SXNzTituR045RFQrbDlFTG83Y2NSbzF1?=
 =?utf-8?B?c2FJVUVPTlFZNG5DalFXaHJrWWxVc25aTTJQU2VydlAxYXNSTjlINVA5Rkx3?=
 =?utf-8?B?cUNOLzNFb25yQk1VNjJzWFl6TThqdStpdjh3bXhSTFlBSk90ZmVXclA2QlFk?=
 =?utf-8?B?dVl2UHY3YkRkaDRub24rZ203ZVZ1dy9NNXBlYVNVejNkZzhLQVp1dUViU2kw?=
 =?utf-8?B?NjlCNmRWaWh4dThQRTZHMjVBYlJzZVVDeTEyYUJ0Mkl2ZzFYaXRINlo2bXpq?=
 =?utf-8?B?VFRaWDc2aHJYMDlBc3JNRS9yYTU5SEN3Y0hqTW1pMUNRTGg1REpJZFhNRmxK?=
 =?utf-8?B?WXFaQ0dWaUd4MnBZSmhOS3Q3NmZoZHJsNUIyajFZNjZhc0pLL1BsUWpTYmQz?=
 =?utf-8?B?NUlDNi9rbVNOLzlGV3YzL1AzUVpSVHB4RmdpYm8wVUEyK004bFlQbDd4YXhY?=
 =?utf-8?B?QTJHTHFtZ1RLL0YwdzBYMjJWVzNkQ21MTUloRnRaSzk3cjQyUTd1dVhMVXV4?=
 =?utf-8?B?UksyMDR6eng5KzZLNHlOSUNxcDc2TGtrM2I1QXg4aVF0UmJ0WGkvTCtqR2Vq?=
 =?utf-8?B?eXpHanQ0R09WKzV1MDhBK1RjeXBiS0E0cURLSEU1WUdaMFhJVms2eGxvZWtK?=
 =?utf-8?B?RHdHRnpxbFhVUXJqNDNGUFpOdGhRRnBXd3pIRkV3OGlIZmppTlBlZGxCNmZk?=
 =?utf-8?B?ODZLZnAzRUlCRTM4Y0tQQXZwWnNqbGRYUXNRL0tRd3ltbms1N1JwU3Vtc1pP?=
 =?utf-8?B?aFZoNlFpT1JGRlVvRmhhbzFMakdQdmV6R29EMWU2ZjFSMWkvam9wSFFQa3lI?=
 =?utf-8?B?SGI1TGtpSlViUXNOcGJlc0JtVEZHZU16REVmUDhDTnZlSHhHbWxaOUx1U0Q5?=
 =?utf-8?B?ZnpnOGVNVjJIV0hndi8vU2NSTDdjV0YrT1ZkU1cxK3NNOEFuV0kwMDhEaVZu?=
 =?utf-8?B?czdaSnZINGtYeWgwYUFDb3BYcFA5NG9pUXFRWjJHcGJ0UHQrRzdkeWVJRzR0?=
 =?utf-8?B?OVFSL2VndHYxbHdxZldFcUk5OEtEK3RTdTRZOUx3eGlXOElSYU93UEhMTEdC?=
 =?utf-8?B?SUVMOGJlajRSMXl1RlZHMHJJSDVhRmFsKzZsQnZISXNKVzNLdWFBZTl3SWZD?=
 =?utf-8?B?UnZ4ZEx2VnZYOG9EMUo0VUtuOTNmL2xETXJHYlJsZWxvamhDRk0yVGQzY1Zx?=
 =?utf-8?B?M3FvUnk2WTdVZkFOc3pMQlRMK3l6Rk1JU2FaQ1JiN2d5ZmlyOUxub0ZqOTNU?=
 =?utf-8?B?QzBzd05vb2l4bzFiSEUvZTAyemRPVmU1d0FrYjJRbzR1T1Z4YUxyRWd5WHVF?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5G31QU7z5Xz/fAyRkRwFa7fE1fZ//CHPCNTmHtCSV+ahjaD8SjpLT2Uhf1rxNRcaWJLkiaEe+CRUxX2v46pzcn+ofnIG+hs1Hj1FST587lC3bIfOccJiPOr2J7YuVRTAzkmfujqdVXn9bV3WrMV08mA4B7XAbH0pbtPq7tt2VdmutH2eo8V20pYp5l7bAEREwBVM8wwTuQRoClBrbWccWNdA1wxW3TnfG9wCJ/rCMjdfIhFNpGuUDb8IzYselKpDoE/1iHNcpBvfi7+x8yyECEVu4S99gQrbWldxU/L8S8MGoE2+SxwuiFuPFVwL/L6frCF+ewAe0lLqY9Na9vdhWYTpqbcfitruh47KoqlfiCNhv1c3qu01Fx5/ll6NRn0eLGhnIXF9RdSi0lzZAvWHqcPSEiTLn8UtkL3UMRSo7GrWuanrSlIe+yby+dG5l9wrp+pIjlhpDzacGRw+KT1wbn6Kc/Xj1JmI88Sv/d45WoNzTbIb+jFXXE3SzGnJemnz7N6e/BcSS8GTEeEzGyeRPjm3SDdADLKbU6kTN6+WBHhIxXxQji8BeIL167NdvxQYMfO7SNGca9oQdrsNGzQgh03fkkw3oofllPcMsDR/MlQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8421558a-c0b5-467c-6ae2-08dc21159cad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 21:59:48.8303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpCVYYUcbm/VmyfNkEsXhUCPEKPJZ1Q82XhhaS9CpMtm+76TRHOYHMr1D2SdeSM7OVljuY7OQf6lhj9fyZfk9m2EKOezlN27GMpXCkIMGe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_14,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290163
X-Proofpoint-ORIG-GUID: fRbzEK2goS5LGhIbTYeASCYmDKMasi9f
X-Proofpoint-GUID: fRbzEK2goS5LGhIbTYeASCYmDKMasi9f


> On 1/29/24 10:43 AM, Jose E. Marchesi wrote:
>>> On 1/29/24 9:05 AM, Jose E. Marchesi wrote:
>>>>> On Sun, 2024-01-28 at 21:33 -0800, Yonghong Song wrote:
>>>>> [...]
>>>>>> I tried below example with the above prog/dynptr_fail.c case with gc=
c 11.4
>>>>>> for native x86 target and didn't trigger the warning. Maybe this req=
uires
>>>>>> latest gcc? Or test C file is not sufficient enough to trigger the w=
arning?
>>>>>>
>>>>>> [~/tmp1]$ cat t.c
>>>>>> struct t {
>>>>>>    =C2=A0 char a;
>>>>>>    =C2=A0 short b;
>>>>>>    =C2=A0 int c;
>>>>>> };
>>>>>> void init(struct t *);
>>>>>> long foo() {
>>>>>>    =C2=A0 struct t dummy;
>>>>>>    =C2=A0 init(&dummy);
>>>>>>    =C2=A0 return *(int *)&dummy;
>>>>>> }
>>>>>> [~/tmp1]$ gcc -Wall -Werror -O2 -g -Wno-compare-distinct-pointer-typ=
es -c t.c
>>>>>> [~/tmp1]$ gcc --version
>>>>>> gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2)
>>>>> I managed to trigger this warning for gcc 13.2.1:
>>>>>
>>>>>       $ gcc -fstrict-aliasing -Wstrict-aliasing=3D1 -c test-punning.c=
 -o /dev/null
>>>>>       test-punning.c: In function =E2=80=98foo=E2=80=99:
>>>>>       test-punning.c:10:19: warning: dereferencing type-punned pointe=
r might break strict-aliasing rules [-Wstrict-aliasing]
>>>>>          10 |    return *(int *)&dummy;
>>>>>             |                   ^~~~~~
>>>>>       Note the -Wstrict-aliasing=3D1 option, w/o =3D1 suffix it does =
not
>>>>> trigger.
>>>>>
>>>>> Grepping words "strict-aliasing", "strictaliasing", "strict_aliasing"
>>>>> through clang code-base does not show any diagnostic related tests or
>>>>> detection logic. It appears to me clang does not warn about strict
>>>>> aliasing violations at all and -Wstrict-aliasing=3D* are just stubs a=
t
>>>>> the moment.
>>>> Detecting strict aliasing violations can only be done by looking at
>>>> particular code constructions (casts immediately followed by
>>>> dereferencing for example) so GCC provides these three levels: 1, 2, a=
nd
>>>> 3 which is the default.  Level 1 can result in false positives (hence
>>>> the "might" in the warning message) while higher levels have less fals=
e
>>>> positives, but will likely miss lots of real positives.
>>> clang has not implemented this yet.
>>>
>>>> In this case, it seems to me clear that a pointer to int does not alia=
s
>>>> a pointer to struct t.  So I would say, in this little program
>>>> strict-aliasing=3D1 catches a real positive, while strict-aliasing=3D3
>>>> misses a real positive.
>>> This make sense. But could you pose the exact bpf compilation command
>>> line which triggers strict-aliasing warning? Does the compiler command
>>> line have -fstrict-aliasing?
>> In GCC -fstrict-aliasing is activated at levels -O2, -O3 and -Os.  From
>> a quick look at Clang.cpp, I _think_ it generally assumes strict
>> aliasing when optimizing except when it tries to be compatible with
>> Visual Studio C++ compilers (that clang-cl driver thingie.)
>
> I double checked again. You are right, -fno-strict-aliasing does work
> to disable strict-aliasing. Looks like clang also has -fstrict-alaising
> as the default if optimization level is not O0. But somehow, clang
> did not issue warnings...
>
>>
>>  From the GCC manual:
>>
>> '-fstrict-aliasing'
>>       Allow the compiler to assume the strictest aliasing rules
>>       applicable to the language being compiled.  For C (and C++), this
>>       activates optimizations based on the type of expressions.  In
>>       particular, an object of one type is assumed never to reside at th=
e
>>       same address as an object of a different type, unless the types ar=
e
>>       almost the same.  For example, an 'unsigned int' can alias an
>>       'int', but not a 'void*' or a 'double'.  A character type may alia=
s
>>       any other type.
>>
>>       Pay special attention to code like this:
>>            union a_union {
>>              int i;
>>              double d;
>>            };
>>
>>            int f() {
>>              union a_union t;
>>              t.d =3D 3.0;
>>              return t.i;
>>            }
>>       The practice of reading from a different union member than the one
>>       most recently written to (called "type-punning") is common.  Even
>>       with '-fstrict-aliasing', type-punning is allowed, provided the
>>       memory is accessed through the union type.  So, the code above
>>       works as expected.  *Note Structures unions enumerations and
>>       bit-fields implementation::.  However, this code might not:
>>            int f() {
>>              union a_union t;
>>              int* ip;
>>              t.d =3D 3.0;
>>              ip =3D &t.i;
>>              return *ip;
>>            }
>>
>>       Similarly, access by taking the address, casting the resulting
>>       pointer and dereferencing the result has undefined behavior, even
>
> This is an alarm since enabling -fstrict-aliasing may produce
> undefined behavior if the code is written in a strange way which
> violates some casting rules. So -fno-strict-aliasing is the
> right solution to address this potential undefined behavior.
> We probably should not recommend -fno-strict-aliasing sicne it
> may hurt performance and production bpf programs should be
> more type friendly.
>
> So I think your option (b) sounds good. Thanks!

Will send a patch tomorrow.
Thanks for the feedback.

>
>>       if the cast uses a union type, e.g.:
>>            int f() {
>>              double d =3D 3.0;
>>              return ((union a_union *) &d)->i;
>>            }
>>
>>       The '-fstrict-aliasing' option is enabled at levels '-O2', '-O3',
>>       '-Os'.

