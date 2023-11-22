Return-Path: <bpf+bounces-15675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EEA7F4DAC
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E731C20A9F
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC2551028;
	Wed, 22 Nov 2023 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B1ynN0LA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qClbFi9y"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB581B5
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 09:00:38 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMGrx81027595;
	Wed, 22 Nov 2023 17:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=srU51JWq3Tw8MxEcIp1k1kM/7udv5vi8CrR+36pDSrQ=;
 b=B1ynN0LAA+Mq5dLkVgBr2lUOZ2eyWplxK8AjPJXMqsmov4TkeQrA7i3Y2VcanhPTcN21
 HlAAUrKvUD/sTERdr3835iPENzxx1dKBm/4FFy37WW/REES3MYp4nlqD/5EsshCC795F
 lNffZ/o+LWO6L1+fh7UT16e6B0ZQqeDC/x/HZNNB1AQUHR5uPrqGFpIutJklcU4CFgVO
 r4JHo2ZOJDpUByz38DKZ0L4r94a1ezuoWdZU6sFTmbzxDQySyy6WP4T1u42mIg1Bf6Mi
 XhhunOUlYq/NP46rrwEf7OaYOk7SFI5wvGvIBTRzrpxXTbv4caCclQyqUHwRjMw2u3ki +g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem2500gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 17:00:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMFdDFW002374;
	Wed, 22 Nov 2023 17:00:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq91b08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 17:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1Y47dD2rH4Xae5n5AJcTQvYsHzsMpCeLnv2SegJV0OcGjvn3TTO+B3j7IHkcxwDcqexto+cGoGjVEDezf7yHR00bL/ySo7AyIagIak8XTsFhI4WTmkl2Ytler38oHggZ6vN7PR5vbvazi5keqw+RaBkc89WH0q5POHrcUqwPh5/gwQBi2Cki8Xjpn5muXWN4uS0Ugc0Y0OhDDI9tRrUfmrjtoRR662y54M8itXori/VxoiPAej/yQlUgdbiYboMJA3X04zvgxaItFngYwXPGrnhsqGe2FlylEkqr1GmL8Qk7Kee7Iatj8mLBe1CyuhLhJo37IiYXfGw4ARAAhTreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srU51JWq3Tw8MxEcIp1k1kM/7udv5vi8CrR+36pDSrQ=;
 b=UblskbROZwaEigzMA3J3TAahAaVnaGeGM7c+2uW5Wh+lCOVst8fzNdwlsnFRtSUDjBzvsRnaD/hSYbubuGhj54W45eVHjbEBFPzyJ4kUL0l8IFJAHMOaptuEtkI854sdh2vGInMK6C2i/GRRQueuFEcLUOSo+iEw7baqb8cbk9FvtZqkFOT6bhP6WFZRuUVOpryfpBDJ7h3pNwFxc5hs5M9pLgbo6WCZYkPPPwiBY+ztri27G5gPgHTVFUokRCRGGZTR95oYz9gSGSJmR4ZHMZx3/xHMB0fQ3euDbmkc32qOGm3fJIQWT16MqLbWQHy0yFt/XIPXifisxOwd+eDsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srU51JWq3Tw8MxEcIp1k1kM/7udv5vi8CrR+36pDSrQ=;
 b=qClbFi9yLin2hZx3KUfqjOy+lJhU2bUhHh2VxwxyogQo5STEmQu+D8D6rTP3FGJlCxVBzG8rc6MdlvNp8nuJ6mwDiEFaIrIC6N29yHBnisV3nw2ZVRaiUg90TtEOhjV2RBPSbAHjrTATGKHT+4A6CPGi9KlgrszVQBIewbcLCio=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW6PR10MB7592.namprd10.prod.outlook.com (2603:10b6:303:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 17:00:07 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7025.020; Wed, 22 Nov 2023
 17:00:06 +0000
Message-ID: <6f56ebb5-ea60-54ae-f2b6-ccd77290cd35@oracle.com>
Date: Wed, 22 Nov 2023 17:00:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 bpf-next 00/17] Add kind layout, CRCs to BTF
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org,
        quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org
References: <20231112124834.388735-1-alan.maguire@oracle.com>
 <f546e2bf-982b-62cd-b2d4-88760d4d97d7@oracle.com>
 <CAEf4BzZa1Z1c+oe2=he_UDgZbowDUvCaDLKKhHyvR5PQqZBNNw@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZa1Z1c+oe2=he_UDgZbowDUvCaDLKKhHyvR5PQqZBNNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::7) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW6PR10MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: a3382b2b-c388-4c79-8736-08dbeb7c7a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6at/mug7xz+5Y4VcWhd04Ftsfvy0FiqD/6LtO+I7BMif39aN7WLmzO1a2/g543oQ2ruakOlmyYzZpdMkRaXdEOOMox3jAtHrGGp3xm+oiVAbpi+7Hl2gi/+bW5VFJRA/0f+HHKnBIshddZJHJO1E6x/JtYmQqQXP+9IibITT7h29rziAl9qvu+WqHZxdzhIJvNyEeMpwp5KhmLYaFc1jggcHQbiigd1zRRYr+D69u3egqsE4V1iU3gnQ39xqjxHUeclqBavB8eC/ZujbQXxe67ES1yhZOBq69h40VLt3G9uaMe4s9VJ3bW17OL65VxV1HDFNrO9wrO9SlS8XjXgb1HP+a6rjXbMHemovV8CGX8wVi+P9JcvpTLGgeeXMoCg88QYVAu7Ole1kcwstS1cFb9b+OtgUtiDgHIOQmsRD68pclx9YXl8QiP6FaAH9u4l2h2Pa8PU78Ca8A06/dYq1gnnvmhtdcar5JESMmFPG/96IE6kqymt2ApJ4jEnV0I8q2SG73CzJAvp5ZUdXE+7ApBUih5/betbD8uQrWEJswUIpj3Z5HmyJZfFAD6R6vkXLKIQHu6pYEXYi6bWDTL3sCSq+elA4anisG3wFVTj3MTfNY5V0B7SYzifozESTvy2ALiu5rdJ5YxcpduJaRKV7hQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(36756003)(66899024)(5660300002)(7416002)(31696002)(44832011)(86362001)(2906002)(83380400001)(478600001)(31686004)(6512007)(6506007)(6666004)(2616005)(53546011)(966005)(6486002)(8676002)(38100700002)(316002)(66556008)(66476007)(6916009)(4326008)(8936002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U0Q3TlMyRStuVnJjS1hmcm9yakREc1R0Q1NrVzFIZmdPMGZKVWhzc2Fsd2Nk?=
 =?utf-8?B?TnNJOVg5eG9kY0RJT1c4Z3pYa2xZTy9HS3F2NFRNSllCdEFMK0QyYVdPTFhl?=
 =?utf-8?B?aEhBWnhLU0VuS0JsV2g0cWFzeGxvRG9nSXgwc01qcmxhcnJaN3ZyL21Mdlkx?=
 =?utf-8?B?R2ZJWVZpVzA4eXRFeFlxV2piQXo2ajBSbVYrYVlqM2Nka3pQcW9wb2tWWXVK?=
 =?utf-8?B?YzdjWVJ3QzVFSGgwZGsyc2RyaFJSRmpvYzB0RXNEM281SC9pS3NlRkpvdEFP?=
 =?utf-8?B?Z2hleE4rN0ZKWWJMVmNySDU5QkZpWldaclhKaDZudEMvdU1iNW9hVGR6UHZm?=
 =?utf-8?B?K0tlQjMxMWsrZ3VEbnRzN2NGYUxaL1g0eXc3KzJrdXZiUmVoVUlqaDlpMUhn?=
 =?utf-8?B?eG1SS1dnMUs4Sy9Bc2hRKzZ6WUlnNExVZFMrUzVZU0FHc1Vpc0RyTkZ5ZUt0?=
 =?utf-8?B?WE8xTUhYUkFpYUkxUXNzY29qVmNWdlppbHp2SnFxYTMrUjNxUVlZaVlWeERL?=
 =?utf-8?B?WGpEVDBzMGlVaU9kUWtZem1GdGQ1d0dBR2VUY3plZGFrbmk5d2Vic1BlU1Fk?=
 =?utf-8?B?UTVYNFIzWWoyZlBjQW16ZU5CQlVQUENGSjJVY01LVUs5RmlwcllYUmZ6UWNN?=
 =?utf-8?B?WGNMeEZWTlVNUUx2Vkp1dVhvNnAycXJRMjEwTURvU0lTS0g3ZjlUeWdTNGhL?=
 =?utf-8?B?bC9jRHgvZlJ6cVlRaU9DM25XNS9yTE5KTU5XeDJ4MlhtamhYN3J1RVUvcDdk?=
 =?utf-8?B?eG94cGExbGRTbnlBdjNRSjlFOUhlTTV5aU9kUlhUSW1OS2t1ME9MUXIrS0tm?=
 =?utf-8?B?WnhjSEl2R2VDbUNGSTZidm5FVjdTb1M1K2dBVlhHZmtTTDV5OS9ZajkreTg1?=
 =?utf-8?B?SldzQWk1ZXdnbTBOeGVCOE5QaEcwUUdISHdEbXpzaE85SHZpMGtOQkQ3ZGxJ?=
 =?utf-8?B?SkREMVR4ZTY0K0dTdFBiZTQ2QkU1Q1lhbHBwVU1HZVR4OEpKZVpqUGtVMFVz?=
 =?utf-8?B?aGk0VTQ0MnExUlMralZDQzliRGFDbWJ1a0oxemZld0FPZitqTmo0TFR1bXly?=
 =?utf-8?B?N201N0U5SUtWM2lGNXNCQXJZVWJ3S2ExVHM1Wk5Ga1ZkdTV2a3UwOFE0Q1dG?=
 =?utf-8?B?L1lHOVk4OHhObXEyQWlDKzVLK0hIajhibDdwYXJCNmVablZwZm5PMWFYRTY4?=
 =?utf-8?B?ZkVhZDNFczBuVFJZSGQzNVdPaVlXelRWZVFTcVRaY2xEQm9UNUxIbmVOYi9r?=
 =?utf-8?B?SnR2ZHhuNnBDWEJRY1JNaUlxNEJhaEg4Z0N6UWxjbnhhOGg1NXV6bTBlYkFx?=
 =?utf-8?B?d3hqaTNwTURxZDJaL3JXQVY3VGxRcU02ZnJ4eDNnRVBSV1FDUFU2SzFqL2ZT?=
 =?utf-8?B?dTV6cGxYWWFkM3VXVGNVOTRWbkxReWNXRXV5a0ZucHlVTGRQT0hML0hmNjE5?=
 =?utf-8?B?Y2VhNEtseGJsTko5a0xhQWNXdC84OXZpZGsxSVV5QzFkTWQzbTdIbDc1NDJm?=
 =?utf-8?B?dmc2U1pFNzFXakRhQ1B1NEV2RnVEeURvNnFmN1U0ZXVTaitQTjA3bHZLTGkz?=
 =?utf-8?B?TGxxTE5TckFwWHRtS2F4UHB0cExub0doanF5S3AxaTE2ai9sL2RwblZhV3Zt?=
 =?utf-8?B?VDhMbXd5bStNNzlrT0c3cDVjbFRLTnhUQy9URm9GL2RndUpZZE1ydk1iUG8x?=
 =?utf-8?B?cFFyTG03aksrQkF4b0llQ21nRS9TV1FyYzIxallNRkFYdW5qMzY1VnI3bWhD?=
 =?utf-8?B?enN1Zzd5MkYxYTFrTWJHalk4M1VDV1N3SW9yT2drMmd6RVBuNHhsQVhWdXd0?=
 =?utf-8?B?UFhwMWNEandKYUhzSmtxSDdQOE9MSUZnRE04emtPVTR5aDViaW56MlA2Y09R?=
 =?utf-8?B?UUpqNDF6UzVNWnYwZXhpVjNwSEFaY3Z4NXZ0S012RDU3U2toc0IxdU1URUpD?=
 =?utf-8?B?a01UdGFnanFPc1lKblIyNWNXbHBuZ0JyeW9vN0pMVEtYUFhCUGFJZVRhWlZX?=
 =?utf-8?B?ejduRTMyMlF2MWd1THlQU1YwZ2NPME9mL2JWUkg3UXBQZUU4VFVpdkhFTEIy?=
 =?utf-8?B?N2tiNllMQ05rbDkycjdwTlpqMkpNcmhnVzFKTnd1ZGxyR09SdWl6SUl6RUVE?=
 =?utf-8?B?OTFJNkMvaG1mVEE1RU5WUkFjbVdSeW1STDcwWEVTUmVBMkorMjFleFNQTS9h?=
 =?utf-8?Q?pcih2ASYK83pRkNdY+DEPa8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?RFhGVmxVaFc4dlpQOGdCMXl0TnRDMTRGVVB3d1d1Y0RZS29iOXJ0TllHZUIv?=
 =?utf-8?B?RUtEL21IM3B3K0h1QkN0ZGRLYmdlYloxSXV0SU9hQ2RJRW5uQTh2QlZWeFVU?=
 =?utf-8?B?cEFwUTVVMUdINnVLdDhORHFrSkVhNUFsTHUvb2lwQUthTzdQSGQrVVl1M1FD?=
 =?utf-8?B?eFg2ODFrbHB2bG1TUmE2YkFxSHZUMkJhb1ZxR3hMdk0xSUFSZ1VXa21Ba3Z1?=
 =?utf-8?B?cU42NmU2N0tIVVhxNnJLUU5tT05mdlJuVWZ5Qkd6SUxQVXJtSmxFTFFySG11?=
 =?utf-8?B?SlBNUFU2TDFJRWZ3TWVEN0xFczBoWVhJUy80VzUvUGhmMzk0ektDUjJsdk8z?=
 =?utf-8?B?VDZwZE9CU1g1SVRSbEdkemt5Y0hHamloUDNJYVFkaVdlcUQwRE9MeVd4ZnAr?=
 =?utf-8?B?WFdEazVHeEpZNFdFMFdERmlXUTh3eVRsQXAvREI1Tjc4WVJSN1ZsMDNvZlRY?=
 =?utf-8?B?cUdBc3dlN3Q1VHBKQUJySzlJU21jeXQ4Wi9jSnBzV0VKT05WTWdRdVZiMnhN?=
 =?utf-8?B?WUlZajFWeGZ4YlFhY2VmeUxEb1FEZWV3UWRzUSs3bGRJUyt6Wnc4eVIva2FB?=
 =?utf-8?B?dFA0RG1jVkNYZzFWaWUyQTErN2xZVDl0dkVaTUttM0RZVjdDMmhaVG1pOWdz?=
 =?utf-8?B?UHRUV0hNTUIxNHcwZWoxUFY1TzhLNmpmK1VFRU45Y0dPL3ZHN0dVOFJrS1F0?=
 =?utf-8?B?ditUb3NKdUoxK1NxNWNmTTRyWlkxQVN3dVBnemNjUEpnWmVDcXRXcjk3UmlJ?=
 =?utf-8?B?MkFFUHhSOW1hbTA5Um5ZUSsyYnVHR28zeFFWWEhnMmQ0NmpqZ3o1RUZjVzdy?=
 =?utf-8?B?bjg4eVBCZHFBMkswUHduU1RoUmZvN0Z5bXZqM2FvYS92Zi95WWlzend3UU1w?=
 =?utf-8?B?Ry9McXc2d1AzTWkvRkhPOWVITER6M2lGMDJ2NVM5bGpMQkprVW1kNWkvQ1Ri?=
 =?utf-8?B?S05aTTVQVVpIS2c0UmxYU3RscExkeXM1MkZJV2t0S1o4cnVxZkJrZlJoaGVl?=
 =?utf-8?B?U3pjRHdJN1lQYWVSVjhuNCtvSm1CRXZaa3pSeTBLN2l6K2FEN1hvbWY2UDd0?=
 =?utf-8?B?K3ljYWJyZ0JhSVJtVU14TjFGSEQ5SU0yKzB0ZHVpQ1JEaUwrY2o0R09IYlJs?=
 =?utf-8?B?eU9Bc1ZKWHlnMnVmZ0krK2pXZmg2SFB5ZytEZGFoa1hBc2hjbnV2RlFRZ1JO?=
 =?utf-8?B?M3VRZVAwdDdHT1VoMlgwTDdTT1lidE40SlBDS09jRU9PYTdnMnRzS0VtYzlM?=
 =?utf-8?B?RlgzK0tVaXVpTnJ0YmdRd0hQbW80SlVqdnV6WWFTMHVqb3lnZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3382b2b-c388-4c79-8736-08dbeb7c7a87
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 17:00:06.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nOeyuGQ9WwU0PXrkIyBh7dNWEpU4KhUNOlWxFJpFDZU34niHvHZ1bHQ7a8q2A+PjLZnaqywCucRLqXZIVgU3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220123
X-Proofpoint-GUID: zn8erSVQKWYCWB59PdQBwqsVLeVdl_TD
X-Proofpoint-ORIG-GUID: zn8erSVQKWYCWB59PdQBwqsVLeVdl_TD

On 21/11/2023 19:44, Andrii Nakryiko wrote:
> On Tue, Nov 14, 2023 at 12:20 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> hi folks
>>
>> I wanted to capture feedback received on the approach described here for
>> BTF module generation at my talk at LPC [1].
>>
>> Stepping back, the aim is to provide a way to generate BTF for a module
>> such that it is somewhat resilient to minor changes in underlying BTF,
>> so it does not have to be rebuilt every time vmlinux is built.  The
>> module references to vmlinux BTF ids are currently very brittle, and
>> even for the same kernel we get different vmlinux BTF ids if the BTF is
>> rebuilt.  So the aim is to support a more robust method of module BTF
>> generation.  Note that the approach described here is not needed for
>> modules that are built at the same time as the kernel, so it's unlikely
>> any in-tree modules will need this, but it will be useful for cases such
>> as where modules are delivered via a package and want to make use
>> of BTF such that it will not be invalidated.
>>
>> Turning to the talk, the general consensus - I think - was that the
>> standalone BTF approach described in this series was problematic.
>> Consider kfuncs, if we have, for example, our own definition of a
>> structure in  standalone module BTF, the BTF id of the local structure
>> will not match that of the core kernel, which has the potential to
>> confuse the verifier.
>>
>> A similar problem exists for tracing; we would trace an sk_buff in
>> the module via the module's view of struct sk_buff, but we have no
>> guarantees that the module's view is still consistent with the vmlinux
>> representation (which actually allocated it).
>>
>> Hopefully I've characterized this correctly; let me know if I missed
>> something here.
> 
> Correct.
> 
>>
>> So we need some means to both remap BTF ids in the module BTF that refer
>> to the vmlinux BTF so they point at the right types, _and_ to check the
>> consistency of the representation of a vmlinux type between module BTF
>> build time and when it is loaded into the kernel.
>>
>> With this in mind, I think a good way forward might be something like
>> the following:
>>
>> For cases where we want more change-independent module BTF - which
>> is resilient to things like reshuffling of vmlinux BTF ids, and small
>> changes that don't invalidate structure use completely - we add
>> a "relocatable" option to the --btf_features list of features for pahole
>> encoding of module BTF.
>>
>> This option would not be needed for modules built at the same time as
>> the kernel, since the BTF ids and the types they refer to are consistent.
>>
>> When used however, it would tell BTF dedup in pahole to add reocation
>> information as well as generating usual split BTF at the time of module
>> BTF generation. This relocation information would consist of
>> descriptions of the BTF types that the module refers to in base BTF and
>> their dependents. By providing such descriptions, we can then reconcile
>> the views of types between module and kernel, or if such reconciliation
>> is impossible, we can refuse to use the BTF. The amount of information
>> needed for a module will need to be determined, but I'm hopeful in most
>> cases it would be a small subset of the type information
>> required for vmlinux as a whole.
>>
>> The process of reconciling module and vmlinux BTF at module load time
>> would then be
>>
>> 1. Remap all the split BTF ids representing module-specific types
>>    and functions to start at last_vmlinux_id + 1. Since the current
>>    vmlinux may have a different number of types than the vmlinux
>>    at time of encoding, this remapping is necessary.
> 
> Correct.
> 
>>
>> 2. For each vmlinux type in our list of relocations, check its
>>    compatibility with the associated vmlinux type.  This is
>>    somewhat akin to the CO-RE compatibility checks.  Exact rules
> 
> Not really. CO-RE compatiblity is explicitly very permissive, while
> here we want to make sure that types are actually memory
> layout-compatible.
> 
>>    would need to be ironed out, but a somewhat loose approach
>>    would be ideal such that a few minor changes in a struct
>>    somewhere do not totally invalidate module BTF. Unlike CO-RE
>>    though, field offset changes are _not_ good since they imply the
>>    module has an incorrect view of the structure and might
>>    start using fields incorrectly.
> 
> I think vmlinux type should have at least all the members that module
> expects, at the same offset, with the same size. Maybe we should allow
> vmlinux type to get some types at the end, not sure. How hard a
> requirement it is to accommodate non-exact type matches between
> vmlinux and kernel module's types?
> 

The main need is to support resilience in the face of small structure
changes such that the compiled module will still work. When backporting
fixes to a stable-based kernel - where a version of say 5.15 stable is
supported for a while and so accumulates stable fixes - often the
approach used is to use holes in structures for new fields, or if the
structure is not embedded in any module-specific structures, add fields
at the end. All existing field offsets should match. In taking that
approach, the aim is to make sure data accesses in the module are still
valid - memory layout compatibility is the goal.

>>
>>    Note that this is a bit easier than BTF deduplication, because
>>    the deduplication process that happened at module encoding time
>>    has already done the dependency checking for us; we just need
>>    to do a type-by-type, 1-to-1 comparison between our relocation
>>    types and current vmlinux types.
>>
>> 3. If all types are consistent, BTF is loaded and we remap the
>>    module's vmlinux BTF id references to the corresponding
>>    vmlinux BTF ids of the current vmlinux.
> 
> Note that we might need to do something special for anonymous types
> (modifiers, anon enums and structs/unions). Otherwise it's not clear
> how to even map them between vmlinux BTF and module BTF.
>

Good point, we'd probably need to represent some sort of parent-child
relationship to handle cases like this.

>>
>> I _think_ this gets us what we want; more resilient module BTF,
>> but with safety checks to ensure compatible representations.
>> There were some suggestions of using a hashing method, but I think
>> such a method presupposes we want exact type matches, which I suspect
>> would be unlikely to be useful in practice as with most stable-based
>> distros, small changes in types can be made due to fixes etc.
> 
> What are "small changes" and how are they automatically determined and
> validated?
> 

See above, field additions in data structure holes or appended to
structs for the most part. Once I have something rough working
I'll see how it performs in practice and report back. Thanks!

Alan


>>
>> There were also a suggestion of doing a full dedup, but I think the
>> consensus in the room (which I agree with) is that would be hard
>> to do in-kernel.  So the above approach is a compropmise I think;
>> it gets actual dedup at BTF creation time to create the list of
>> references and dependents, and we later check them one-by-one on module
>> load for compatibility.
>>
>> Anyway I just wanted to try and capture the feedback received, and
>> lay out a possible direction. Any further thoughts or suggestions
>> would be much appreciated. Thanks!
>>
>> Alan
>>
>> [1] https://lpc.events/event/17/contributions/1576/

