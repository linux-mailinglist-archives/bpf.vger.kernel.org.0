Return-Path: <bpf+bounces-11253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BD87B64D6
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 10:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CD0B3281752
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 08:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46441DDD2;
	Tue,  3 Oct 2023 08:58:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC79DDAE
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 08:58:54 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288E1AB;
	Tue,  3 Oct 2023 01:58:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930jCT9028403;
	Tue, 3 Oct 2023 08:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=i9+uYSgmyZVa6tPl2j/fqDCxYG+Nk9rlvVdAIELn+a8=;
 b=KCVPrfNbj7F1O4TwXdWFUgvwGzsaLaTu8Nu9W45ti0bDUF88KyaAPTMhnriD75T4Uwyf
 muFa/8DsxxfFRXRxWG8TK7bsp4M8kTjxvea7Zq00LSM+hH9Mi5jTvOe0WTPbs6h+0gKj
 od4jYSfG2iRTSvikVRYT3v/LpdgeqwOpkkc5w1HmElwcg1H0CIhsKK9exp0qXr46PClU
 LWnuTcGYmIfrtu6EMn8wY1brfcGDnGxbVXrc7VaEmluiDmsX5hwi7suwT1Ur5eDggOL1
 hIW74L26aluSkHMqZue36GbvbFJZitqBkPgD/asuS46rDfUuvKXIHitP1UVjvn1XIhBS KA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vc5w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Oct 2023 08:58:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3938J8qE000345;
	Tue, 3 Oct 2023 08:58:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45n1ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Oct 2023 08:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLzs//h+GkdZ4p4WjxIKgOcmKzMOhvMGt/5iM1ihK7dmux/Mddw9UUdq1n2PW2FEmPHUlUlQHvO6ySYPZx3KYn/vaihK/PmN/GafkcJ2KLkedw0b2qml2EHWw7Du37eK0AzQp6utFpJ2suQDHoqLdnEBW1WQpi6eZgvo7X+rx2ihcf6aITOiyuwSn+Ok2ptKMiTmXbzyEoYb4idT0hzFsMkCHKoALHXp/vPY2gKJrpZyp0bD5JeCpSqlc31hUtl1xA9rFfYU39cQ2HOqhe644LWEMqrZAnEkrgcERL0AvdaejRuSwQdSapESzghQZss2pUVA1BvhulOM0zwH+It3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9+uYSgmyZVa6tPl2j/fqDCxYG+Nk9rlvVdAIELn+a8=;
 b=iYiP1kAbcbh0E2BccF9vs70AgDpqg8GFc5R/YSJdqEA7Go13nhN6HLFd4VU3fu/lzQFHn4kiPcXHB8dYT2zqqhKQquNr0ab0LEu2iSBZ2Bqnwn7ySNJtjpBPDdfFpL3fWLXsuK/UBfWD8WBpJpCoNi5h12ptYdcGgQ2HHI4V3PtWsCiw6REPvFag5mX4BAowzvZPiurSCNAuZukxRAeh5zufZcqrebz5tjH/2ibnRnB40IG8VxJyR8pJBxBMOlTS3o+runVCBn95oNtTYD/4Y0rIBMHgbg/ix6BJiW3x8rcvSCgHJFW3LzPyMqj59pL8ZXtVab9VHEncbNZuwQCHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9+uYSgmyZVa6tPl2j/fqDCxYG+Nk9rlvVdAIELn+a8=;
 b=Y99wwdQWlmfPQx3peh6hjSyIO4S+dDIbwSjIF8FjEZ1TlvUextuyj61rSMvrGeFrlAqEsaogkVYerc8oxbCVhJRDjHtjGWXmQCQ2RlVIbUy1ikbO0qa0GrQJhIza3VwEB9hWYro+2r37xlDF8ov6YOT0at0aRlP5IgrGhxzUyPM=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 CO1PR10MB4419.namprd10.prod.outlook.com (2603:10b6:303:95::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Tue, 3 Oct 2023 08:58:16 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34%7]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 08:58:16 +0000
Message-ID: <0f367aff-b818-d59b-513a-cadd6fa67782@oracle.com>
Date: Tue, 3 Oct 2023 09:58:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] bpftool: Align output skeleton ELF code
To: Ian Rogers <irogers@google.com>, Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231002223219.2966816-1-irogers@google.com>
 <CAP-5=fWmxKHLGnQqBjUb8MZFak6YaKMPGKKWwBiCc6XWZbVPDw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAP-5=fWmxKHLGnQqBjUb8MZFak6YaKMPGKKWwBiCc6XWZbVPDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0277.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::8) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|CO1PR10MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 640c2aaa-41d2-4f2e-5bef-08dbc3eee1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FtL3bPinR3SBNYwVv/wG5mcn8TbXvtBRxrwtjx5mAAnayRPa/zRNvUSp6YQj0PdNlY+tTF0cI8Ytpsvlc2YkRvc0ps/S8JbFsGUB3mBPcKZlXpSb4Uu7KtqxvMalb4plkCt3GKm2dW0h88794A/6ULJCytXx6yGrMgmP4oGukX0WHvhdum44TBLdX3fZCI/Z7IDm7cuCpc35c9LvQn35GghAegAo7P2uKZHjHhynr32vQLGTxAjMinZQ81145q76blt6Tg4ioZCK8fjldbL00IseS96WqhkTLB3wdcsFp7zJIWwVEkKaF+dF3GXEI36Nb9RpgUd+OuirW7ZJGYn2qbJUig2SWgkMbc+rI8fSgMA1u71DH9N9wS5ZodKWW3C27v/PjpLmWQAwUFwQDSE6GgIOW/WSWFNChTrrur1Xd9F8rvVxWXtTgmnbYI99xnyW19qr3SpnSG12XHalxoXpbhVJWY2/m+V+h9JN0qRHhxHsPUA19wRPQxJXWqy1WgdFitCVKD92qwkTvToc+CYWgr5nrv+iUu48NNxBOTD3CXReoe9LhqGiawop6e6Bed4D5e2pRjx9iLqVH7qf+C5KW4j7M1l48aK+CT8cZLyONMUy3O8kDdgP+dRVpowF44e2E9OrtxKjkXUbFO/4YuhLuoJBPL17UQo2x2R5iToYFhQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6486002)(53546011)(6506007)(2616005)(921005)(6512007)(38100700002)(86362001)(66556008)(66946007)(44832011)(31696002)(7416002)(2906002)(8676002)(36756003)(316002)(110136005)(5660300002)(8936002)(41300700001)(66476007)(6666004)(478600001)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0ZwV0JweWRSREpiRnF3OW9UeHp3YTJ6aGhzWWh5ZkllWVNqYTJPNWtWVEJ4?=
 =?utf-8?B?YzlEWDRmaE1VTkJjbWFXaisxdnpTUXloc1FWWXJQRmloME45MDlKSEgzVUgr?=
 =?utf-8?B?OHFRUDg0ODF1eno0VHVxME1QMGxyVEVQeEF3SFh3eTQ4a1c4OGtOaXZ5a2FC?=
 =?utf-8?B?MzNZQkRFSk96QzE3TElDdy9TYkR6a2pGTmVxTnprZERQQzdZM3dkYWoxZnM5?=
 =?utf-8?B?cEFmanc3K2l4USs1QWVlQ29td2p5R2R0UnlRL2xabjhzdmtTTG9NamtZK0NB?=
 =?utf-8?B?Uk51RmZPYzBKbFdsazFRdUZxZkJHUVVFOXlsb3Q0MDFiZDhmanR3KytTS3Yv?=
 =?utf-8?B?TjU2dmxTMWJhbWNaN21DbGVKM2MvVS95QkMwa2JodzJwM1lVajdEVStWajFj?=
 =?utf-8?B?WHZMdTQ0MWl0eDh4VEgzbXF4WlNWQ3d5WHNDeW52QUNzdXdxWU1IL2JRbWhO?=
 =?utf-8?B?UUxEQkxEWStGVkN2aDJSZmk1eTgvWmc0RDl4R2ZMbnZ3RXBnd3ZBRFlGcFJk?=
 =?utf-8?B?dXJqcFpNZ2UvQ29qaEgzVmdGZGUvWWVhamFPQWI1OVZjeVA2b3Q5Yko3bHZH?=
 =?utf-8?B?WnFDMFN4ZHVLM1htNW56eUN1ZGlibEZEVWw2V1NmLytXZzFrRnZmc3cyNW9u?=
 =?utf-8?B?Y01KaFVGbktjd1prMy9TSm5wVTZFYndndTcvL09CRytOMWZvUTViTXQrTTV3?=
 =?utf-8?B?NnhOTDRuYjU1UU04eXdhL2NaYk1zTUtuakVwMzk2RXFqeCtjTmFXOU9tNVU3?=
 =?utf-8?B?TzJ4NnNKdnVqb2w5N0UwMTB5Rm01amIxSzR5WVpJbkRITEhoUUtSK0RJaEgr?=
 =?utf-8?B?QWp2eUFLSW5vcGtWUXNoTVYyOHkzWjZRTVRzR3grL0xFWkFuWk9ZRFQ4Uzcx?=
 =?utf-8?B?eFAzK2J1ZjdjKzJZdEJ4UFFTa3lSczREU24vWmlpS3BQeS9sYncvMHVRVnhu?=
 =?utf-8?B?MURFVGNYeHF6OWhma2lDbHVnSFJCeGtNOWFZOVVhd0xjOGd0MnB2Uk1JR1B4?=
 =?utf-8?B?R1BLa2tOOW9hazl0NWNVeUx4bS9GN1hJS25FU2hkVU4xTGtIYjA1Yk8yMVlw?=
 =?utf-8?B?WDc4NjlNUFRFSlc4S1hIM29QOUFycnRieU9vMXJuYnMwbldtUUFUUnNSQmd4?=
 =?utf-8?B?eGd4THhpOUtpek1mZDJtd1R6RDNsRXFBbkptQVc0bkJvUytDL2VXa01VTEVi?=
 =?utf-8?B?bzJZOFUrdEhJaEhRaG5vdUpXL0djaXRXWnh4aHlSdEtIT1RGSldHZVlSWWth?=
 =?utf-8?B?N3BWbEtHclVMY1ErS081OGQvMEVVMzFIQXphTG5KU3VhK05SNnJwdjRXUHF5?=
 =?utf-8?B?T0JneFpRdWRrcHM5a2orMlNobWh6MU94YnExTlBGell4SUorMXRWZytmZEg1?=
 =?utf-8?B?ZTlmRGk4ZlFmaVM5R1ZyWkNCWWc4UXIwaU5DSkQ5bUFIS0R4TnN2ZmdFZWl0?=
 =?utf-8?B?aTM4ZC8zQ01ySWdQdHZDYWR3YnYyS2Y1bHd3U0RSOXdlZldzdEd5TllCaklz?=
 =?utf-8?B?eHpCNS9FNEVWb0kzVU9GNUYzRzhIaldmSzh2SExXa3hJdkw2RmFGbHEyb21t?=
 =?utf-8?B?ZUdYZGFjSXFGeVVaMDNIdkhHTURrZFoxK3dPcElpT0Q2b1ZXZVlRdGhxeGxY?=
 =?utf-8?B?bXhuVGNRQTVnNFFzcTBHb2pCREtIUXlDT1l3aFc4blVWOHRCOWcxbFNBYU9K?=
 =?utf-8?B?eDAzMFd6cjh0OFUxUXQ5NjJFRnY4R0d2aTNoZHMxSTBYZDJmbzV5YzJDaHFm?=
 =?utf-8?B?bEV2VUd6OFVtZFRwRmE0K240bTA2UmhNUkpkK29vRzVQWnkxbEx1cXB0eURh?=
 =?utf-8?B?TlFxQk9aUlpYamhTRTlRNGpxMUlsZWlWNEJGeE1Ta2FKYitMbXhvNklhb0RF?=
 =?utf-8?B?V0o3TjVIUU9qWkFTWWRVZVFpMWpwczdEeVhmcC9nRk9JNTdMUzV3b1hrMW9E?=
 =?utf-8?B?VVJCaXh5NHNoZjFheWlhNDZVTzZVeUtPS2VNNTk0ZjcyQWZUUDJIdm5pOUpN?=
 =?utf-8?B?U1FFMElsVnZHOUJOZmxSRWZMRm8xL0ozTVdkSXpJWUdRbzhueVZoaFdQbEE1?=
 =?utf-8?B?QmlGZEpIMWpsUDZpUmJDVVFldkFPaS9BeEpKQThVYVNxeGRNSWVEWmo4eDdZ?=
 =?utf-8?B?ckdmdzlOUDlDN0dFcWFsZW4vU1QvRmpac21rT1VKdzlmT0J6azIzWjJNc3VP?=
 =?utf-8?Q?1hX3m9c68oiYjSuGWYbbNS4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?Z1BRRjYrWFB6SkJGcnV4SERzRXlzUHEyYTFiVHF1amhPSXZqKytDTUtTVS9x?=
 =?utf-8?B?TCs2SHQxZWcvbW1tRVg5aXdrOWF6eGdnVW1WRlhLcVdCZnAvRHVzTHl6dlI2?=
 =?utf-8?B?d3pmNUdEWjBaSmgwK3VRcHhvdHBFN2NpenJUWVVkSENEeDI3TjJ6NFlqaHhJ?=
 =?utf-8?B?cTZYOWR4NFFaT0h2TUdOMWZXNWRDRmg1aGM4d1IxSTlod0ZyalcvdEtJOVdN?=
 =?utf-8?B?WFU1cXd1eVdrWVA0Ykl1WnpQbTBzRGcvKzBkSk03U2JRK0xGRk4yMlRQa3pU?=
 =?utf-8?B?VHoxY0Z1OFduQmM4ZHhLY1RDOGtVUzFsL2lkSVBHNlkzQlBSRXAzVXNlVGxM?=
 =?utf-8?B?VXlja3Iwd1U1SEdGNzhkODBjQnRuN1FDZUFQenBXdmw5TUdoTDRCa3JDaktK?=
 =?utf-8?B?UjV4Z3h0VTdOODVjUE5DMzJtdXhHNFVjMUxxL2JSN0NSUW9XY016dkhUMGI1?=
 =?utf-8?B?bHBOc1FLc2YyY2c3UFlZaHRkdUxjRVlQcDloS2dLZ21nV3RCZnB3bVVlaHAz?=
 =?utf-8?B?S3Eyd21aUkRmQjVoWmNUZSs3SURPUnBiUDlwTjJ0L1E5VE1XTk94RlptcUlD?=
 =?utf-8?B?cTFMYlc5dmo1N055YzBnNlpXMzNmc2wzUWtpZXpGc3BudFRtUHhZUU1hM0h0?=
 =?utf-8?B?TDgxaVBuNFROaFA1L0xYMFJRV2lDa0tVM1doRkhKWVFvRWlTWjIrc3ZOOTlZ?=
 =?utf-8?B?NGNRc3VYVnkyNCtpM1pQakRDM2RlSlhLS0VqQjAzMm82SDNoVjUyeFhYVjZx?=
 =?utf-8?B?eTdkdHppWGxJUHVsNXFDd3dySlZPS2xvOC9IQnp3c2U3dTJ5aFRGd2lkT25v?=
 =?utf-8?B?STZnTlYxVzFDUHEyTWxhTXpaM010SCtsNE1hTlNCZWIyWlR6dGdPdEZrc2Nr?=
 =?utf-8?B?NFhtSFRuUGF1Ym8ydE1ySlM0eTgwS0ZMWG5GMC9DRnBDbDVEVEZ5Z25IUURJ?=
 =?utf-8?B?bE9nRzQ4eERTQkoyazI3VHdxTStwU256cHRpcllmMmcydnl6OWNvOWJQMEky?=
 =?utf-8?B?OHN2a0greWR0K05kcktyVGwwOVlQOGY4dUJBM21SbWpXblhoT1JtdTdvRkJj?=
 =?utf-8?B?T1F0UlJKenkxM1JMRUxqRzJqK2pMUnkxdjRFc1hVaTkrSTFqQ3hhVVhnWUxT?=
 =?utf-8?B?R245SG12bmhpMklrT21XSm9OUEtWYWZxd3lPak1DWGNVMDlkblZFTWFUQ1JQ?=
 =?utf-8?B?cEpMUEdQQm5wUUNzYlFEQ0lycWJQK2grZy8rL2Z0a2ROaG10YnhuaTJHWGEx?=
 =?utf-8?Q?Hjf9iW0t5d4JRiq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640c2aaa-41d2-4f2e-5bef-08dbc3eee1b1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 08:58:16.2623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gE4xbfZvULGxXVE/2RUPoKrid/PKoXZHROl//ymnp4rSwnoaNl7ANlis/7tFnRDOwVSz/gdDkC901pKr0sCm7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_05,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030056
X-Proofpoint-ORIG-GUID: eoN5HFO9t3FhrkdZvjTR9s4yXEecJNLh
X-Proofpoint-GUID: eoN5HFO9t3FhrkdZvjTR9s4yXEecJNLh
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 03/10/2023 05:29, Ian Rogers wrote:
> On Mon, Oct 2, 2023 at 3:32 PM Ian Rogers <irogers@google.com> wrote:
>>
>> libbpf accesses the ELF data requiring at least 8 byte alignment,
>> however, the data is generated into a C string that doesn't guarantee
>> alignment. Fix this by assigning to an aligned char array, use sizeof
>> on the array, less one for the \0 terminator.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>

this looks like a great catch to me!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

>> ---
> 
> Perhaps this could have a fixes tag:
> Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog
> load" and "gen skeleton" command.")
> 

Yep, or perhaps

Fixes: a6cc6b34b93e ("bpftool: Provide a helper method for accessing
skeleton's embedded ELF data")



> The unaligned problem was seen in perf's offcpu code as well as bcc's
> libbpf_tools. I didn't see problems with map data and opts data, but
> inspection of the code shows they likely have the same issue. I was
> testing with -fsanitize=alignment and
> -fsanitize-undefined-trap-on-error.
> 
> Thanks,
> Ian
> 
>>  tools/bpf/bpftool/gen.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>> index 2883660d6b67..b8ebcee9bc56 100644
>> --- a/tools/bpf/bpftool/gen.c
>> +++ b/tools/bpf/bpftool/gen.c
>> @@ -1209,7 +1209,7 @@ static int do_skeleton(int argc, char **argv)
>>         codegen("\
>>                 \n\
>>                                                                             \n\
>> -                       s->data = (void *)%2$s__elf_bytes(&s->data_sz);     \n\
>> +                       s->data = (void *)%1$s__elf_bytes(&s->data_sz);     \n\
>>                                                                             \n\
>>                         obj->skeleton = s;                                  \n\
>>                         return 0;                                           \n\
>> @@ -1218,12 +1218,12 @@ static int do_skeleton(int argc, char **argv)
>>                         return err;                                         \n\
>>                 }                                                           \n\
>>                                                                             \n\
>> -               static inline const void *%2$s__elf_bytes(size_t *sz)       \n\
>> +               static inline const void *%1$s__elf_bytes(size_t *sz)       \n\
>>                 {                                                           \n\
>> -                       *sz = %1$d;                                         \n\
>> -                       return (const void *)\"\\                           \n\
>> -               "
>> -               , file_sz, obj_name);
>> +                       static const char data[] __attribute__((__aligned__(8))) = \"\\\n\
>> +               ",
>> +               obj_name
>> +       );
>>
>>         /* embed contents of BPF object file */
>>         print_hex(obj_data, file_sz);
>> @@ -1231,6 +1231,9 @@ static int do_skeleton(int argc, char **argv)
>>         codegen("\
>>                 \n\
>>                 \";                                                         \n\
>> +                                                                           \n\
>> +                       *sz = sizeof(data) - 1;                             \n\
>> +                       return (const void *)data;                          \n\
>>                 }                                                           \n\
>>                                                                             \n\
>>                 #ifdef __cplusplus                                          \n\
>> --
>> 2.42.0.582.g8ccd20d70d-goog
>>
> 

