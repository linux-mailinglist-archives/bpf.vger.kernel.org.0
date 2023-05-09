Return-Path: <bpf+bounces-262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF06FCDF9
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 20:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69C82813DE
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE4514A8A;
	Tue,  9 May 2023 18:44:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A614A80
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 18:44:34 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BE41FD9
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 11:44:32 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349EEVDF015886;
	Tue, 9 May 2023 18:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Y40ltaD4HZyK+D+3swzwZ2JAmJQrPouZKs+5t2h7qWA=;
 b=ZBUJ6bpjvFs0U2b7mYR5BuEPSRTJJyrdtKJ0kRn1H667kpc9OEDttCE3UTn6FSCQ8wRs
 tjx4KTtMHWNugEisO9hVN3pUtHOqYTvg343vAF8yLtPvRI1Mte5x1N7ZD17h5fjlMdN6
 Ra3AHtIjRhdzaDvTXGTrw0Mo1L7uqFkjpWLubu9yd+9UD8jUoLLwdRsruz5/8Qalhh1y
 z/D8wSZhQzocG4rUUOfy7kA3jOHhYC1wzWjoLHzGJTTxaLnuUiYsRqa4SDjBtJ3DWa8t
 SrzSRpK/C99P2c2B45a+0XA8cOFNI/5Oande1gpv6lPjmauxOpx9l46ji+aWnaHyRwc0 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77dannm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 May 2023 18:44:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 349Hu4nu007574;
	Tue, 9 May 2023 18:44:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7y4b34p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 May 2023 18:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jyoa6IJTJ6sa7dZ2yEa5xScXXSe2XU92XWqNopAWY7mKofHpeQgW5TxbO7IXeUUDZto60FFb06HSwNO/tFD9QsLkwtqcLr+Q3CQ3QhxIY2fR4PL8NH4ouGpwYhTn1Gc4YCV9BoNbs5EpWjYEJtKylR/y5M0pDJJmepQ++KonVuqaR6D/0NPZ1GTjHkN74u9BJhjeCJJlEDpZcGnIijVwI1IxsfkL7UpEflAUkXz0Hn91KgIGd2XEd7ThFcAj2qByOjV22AZW5hllgBa7k/1SPRAJYz2BywAMPLDIg/q4Z0ZpWU6LMLs0jf1nYpC4SwakM2in4KjZQwWoO0euR7r+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y40ltaD4HZyK+D+3swzwZ2JAmJQrPouZKs+5t2h7qWA=;
 b=I2bvk2dNMU3y4GZ+FbOcNfFB2eJfG2MdnWoJNiosAEUa0Km+QczG7wPTq500WMmIGobGRVsT/bv+nAHgGe+LtSVtiZA4x0S/k7EMLm9oWw0tiXSXOfG8tV9aoUsrfiihJLH+qUusvoT8DsCFr5zfz6sp9J9mICFPXG8lWEPMqgLQ9NRDVcAYoUVMybpk79D3lJg2d54Qub1d5tMQ4ZOB8mCNLOK3K9nQRCzFBFJ/Ej+iyQ7qdqQwaVMYXxTnCmdOkp14gmrLgTTVfmkPIaCV++69EKs9SZB/rBUyQtmJ3BxT5pKnTBx/66YrPbKcLNUJiX+AIOTjWloLBMOBOM3QGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y40ltaD4HZyK+D+3swzwZ2JAmJQrPouZKs+5t2h7qWA=;
 b=ubOwgvz9jP8fgnmkX3LlTpZIwL1u1H1bwEubimUr7toQt/god9IevJgZBE2H9h3Whh3/zjVVePFnChyXop7ThtmmTzDx7OxMkzokO/gPv/9g4zff5y/QgzekJZdzYXFqdxsvyZLWUk4Y/6+vCb10UdXJWDpIN7KAY/D88ZN0QC8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB5379.namprd10.prod.outlook.com (2603:10b6:208:325::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 18:43:59 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace%6]) with mapi id 15.20.6387.018; Tue, 9 May 2023
 18:43:59 +0000
Message-ID: <0d9bbdf6-12b7-a9a3-9bf3-7f67b01c5c3e@oracle.com>
Date: Tue, 9 May 2023 19:43:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: pahole issue. Re: [PATCH bpf-next 2/2] fork: Rename mm_init to
 task_mm_init
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20230424161104.3737-1-laoar.shao@gmail.com>
 <20230424161104.3737-3-laoar.shao@gmail.com>
 <CAADnVQKr3bmG2FfydcbXjwx5gML7NYjPiDtW+B1D+hc7hmD3QA@mail.gmail.com>
 <CALOAHbCFAV1Tvko1HWhD9CYTqcY_ojP47ZxpWhyi=Sib8+5iWg@mail.gmail.com>
 <CAADnVQKx=dnd8_jaJGcric955MfvaHqKq=WSgVKc4wAWj_fORA@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQKx=dnd8_jaJGcric955MfvaHqKq=WSgVKc4wAWj_fORA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0209.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BLAPR10MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c2c7c4-47d9-42c9-c909-08db50bd5a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	R7f5wut1zT44nbVI/+MLUzIRGTAUZdJ83t52UO2tmgVECtkGrBrZ7wHCoVtbfQ6+WRyS3d6DuzuC1G37Rwxa2KsRjnV/AWCMvBaLdhY0L+1X8Yo3eFiEZ6ChmvAm86x3wpfKKZgFZok1ST5bxpvpr1fxntSkmQPW3rnAKpPAOp0lvuWkoc4n6euSw9DAEhCEJV4f+3x5dvziZOpEICBFoPJWctY+rramNNFsbU7UVtjuEqVqPqFKO/fnQnl3W0GV4Qk+4+fDuVgZeZ7UDGOPJKffIj2yE/1kwoWz/XfVRRxOfBjqSMeZHyBN4mziYioT2MPhMYFc44DgmFXsOWCIT5p4a3QJymTEzwDOq+XIMgCwhQjqo9t9d9N4ZdfpegarfO/nw4PnuyHvaUkhTpYlerkAGW4Mh5ASqYHEAKKBRTSlh2xxs5iP4aMudBsF/dsE7veNA2kslu2t2zpF4Zj8MgO4iaZ6UUKL/dtb8XsZZpDWxTaGrdPTHyNT6uW5NTY7nPxsHkuXFiuwleD6GOlt1+xEwht1DPrZrDUWsWRteVPLY2lD8SfhdA30ukwn/8JMKplMcis4tsQmtrVGhAq+ByimfjR3mJdUGaNnFa00g44YKRbmUJEz1xrbR2iGuFVNacY2ZktZYnMh1pkSK3hrXQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(66946007)(66556008)(44832011)(478600001)(4326008)(66476007)(966005)(8676002)(7416002)(8936002)(5660300002)(54906003)(6506007)(53546011)(110136005)(6512007)(31686004)(316002)(6486002)(6666004)(41300700001)(2906002)(2616005)(83380400001)(186003)(31696002)(86362001)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cGZZWXhzNUZQU21nQWhocDl1ZmZvYk9YVmlWV0l0V21QRjk0cGIyN09TUm1W?=
 =?utf-8?B?OEZCT3VKT1I3TkNSdHZ1ZmlOM2FYL2wzRkt4TUwvTVc4bkI2Ty9ZSTRFTk1z?=
 =?utf-8?B?QlJtWUN2aktUYWYrSUdMUjZZSTgrc0FBVXc1ZnRQQVAxK0RLRTErR3ArNGRv?=
 =?utf-8?B?WFpnZ0Ftd2pQSzhQWHQ4MkY3OUVPSW5tZTdsUjE3cnRuZzhKMTBzN21tVGo2?=
 =?utf-8?B?ZG5ZMTdKU2UrL0prTW0zVkhXdFZNZHF0NGZ6RWoxcHNmWnRaSkpiL1F6alYx?=
 =?utf-8?B?eWV4ditEbDdKZTgxZm5GSmpybzk0NE4vNkVTQjNLU2lTblJwQmR6bnJWcmlt?=
 =?utf-8?B?VmVoaWhlR0dNQTd3a3hVN1hKWnI3UEx4OHVucU9kc1QrdTNwSnhxN0liVDVR?=
 =?utf-8?B?dGRvSmdxb1Z2R3N4OEc1bTAyQ2phMjlMWkJKVlE3SE45TFlIdk1XS21SL3FZ?=
 =?utf-8?B?dXJsT3YvNDY3NkNYMjcxblljOFlidlVINjBKaktFZTlBQWR4TFpUZ1ZkbnZ2?=
 =?utf-8?B?b3NoOWxMcUtxQ0pRMFlwak84ZkQrMzUxaHUxcHJzTllxYTM4aWxBTTNVTndY?=
 =?utf-8?B?aTVJaXAyS1N0a09MWDBTL1UwakNEMWszUXM2emFhYmJvYnN6ZTRqcnRNdCtB?=
 =?utf-8?B?eUpYWXpzelN3RmlsOTZFd1F2Y1JvK1krd245aHlNVkxubXVueWdjcUNSY0F5?=
 =?utf-8?B?OW4va2lJRXR2TmFFSkdsVkJ4K1dmeXRzVVRaTW1rQW5waFIvZWluSm9DZEFZ?=
 =?utf-8?B?T21rQ0JmOVlvdUZtaHA2bkVidE44QkZBM09nOEFvRUd0cERjZ1JXbCtGVFdz?=
 =?utf-8?B?cXdRb1AzM0Z0YmNKd2t5dGtpWUg0ZTM0NTZJNHVUZHl5c3NqNHZDbHZtWGpq?=
 =?utf-8?B?ZWIzZ3dtK2VwajlvSUJvZFFwdzlXS21DL0VsaEFab1NLY3hVNlova05rUnVo?=
 =?utf-8?B?bnljSUlrZVhtdVIrUmIxaTVzWVp2bXdsbm1mWW5SRG1JUEpiOGt5aUV6cHJZ?=
 =?utf-8?B?SExQN1dpYXhBQXI2end0VWdwZWZPb2czTU1sQ1VETDh4Qzl4M0liWHFuUkU4?=
 =?utf-8?B?bkppUHo1WDVhSnlZd1RYbHFvUHZwNE5HdTE3U0hxSnJWSXJ1cGlwT25IS251?=
 =?utf-8?B?NmFwK21QSUxzSEN0d0g2MkVqaGtPN1dSd3Vkck05NTlnWmRRWGJLV256bDVQ?=
 =?utf-8?B?a3hmWDRhOXRFcHhYTUFlY1JiMmtaTXI4WE5SMjBCMDZ3UnR3cTJUWlFUYWhJ?=
 =?utf-8?B?ZUFrN2VtK1lLTHQ0bWpDa09sTENyMFNXUm0vdVZpdlFhWFZKL204VEdLOENo?=
 =?utf-8?B?bHVNYXdxcDBwR1grTE1GcGJuTEg4NG0zdmFTU1EvVmo4aUlsc3IyYWhZdVJL?=
 =?utf-8?B?VmxxTXU1TVNHZktTVWlEc2NHdjU2L0Q2dE1wbHRCUVd1Tk5RTEM1Zi9mOFZT?=
 =?utf-8?B?ajdhV1FLejVmNHlibDNPdjAwSXZQaEsrRVRPbWtUVmFwOHA1L0YwaGtsdUk3?=
 =?utf-8?B?ZTJkSzFZdDlSNXRDQXNIblZwMkczMy9WR2pjSk1QZldxM1AwUStiMXoybjkx?=
 =?utf-8?B?SnR3ZnBzSHFZZlBIL2RzTG9lSlhrOVYrLzBCSFJ1Zk52SEo0ak1GMzN5Ly81?=
 =?utf-8?B?ZThxb0IrL2N0bXJpMCsrQ2dxNG5hMk5qN0F1eGRwZzU1T2p4WW5QbnRNdG9q?=
 =?utf-8?B?NGVjOW9yQzhob1hFSElxMVZDRDVJa29NSm13N2J1VkM1MVNkTkJFNW82K0Jv?=
 =?utf-8?B?Sm5FeEhrQlc0TTg1c2VDemZuQjI5V2RqRGc2U01XcWFQZFZSSURKVW1USk9r?=
 =?utf-8?B?Rld5SU9tZzVNRmY5WVJISHp3L0k5dGFyRmJ1VlF4ZFFWT09TY1pmMzVrSlE4?=
 =?utf-8?B?WDlCK1U2U3BpYlFHWTFESTFCc3NWcGNsVWpyMzJSTHJ2R0NaUy9rRForNkRE?=
 =?utf-8?B?SEpLY2lET0NMS0ZmR0NydzhGMUlFdzNNTHBpbU9kY2QwQjZhOHNJN2hIY3NO?=
 =?utf-8?B?dVkyNDhKNnZ3Mkh1TGx1azJQdUs3Z1NmdEwrbm1lL2RsaDRyOGowZG93NnJL?=
 =?utf-8?B?Q2RUQTQrQ0h1WVJwL1A0REMzOVlpWDJnT0ZIUDlGajM2b3VFQVN4a013M3c5?=
 =?utf-8?B?VFVXeGNqdHJWVVB5VTRIVHlDUy9IN204MTluMlArRVJTc3VnNW9PM1lpeXlQ?=
 =?utf-8?Q?VTuz4Jd0abULDiKuIFvp+Fk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Sa5O140ZnIVJPPvgOjAZnVWX+x3QlrqboLQpG8yFD3f74+tRtF0++mmtPDolGjLloayonRywKS1UOYYJ97G7u7pKywhXFu96os7zObpX7nYd9tKVVufmGAgx17j81HvmRz4XO1dBfFc9wT967ljna5sy6pw0180KwcM1NIp7sW2o9tuOjRRvrTo27QH45QInZanBVKdvTn20HkF4cFGcrJg8NfIyx66KjaeKACffJlcD5o64UXFAuS2JMpEyvzUewaSr8sSii+omsiXZ5uJEL7eHb9QTHm2nmlLUcZa8db4Q/UO7AwmBeS4Mdxda7NopgNFlyP8Tz5HIMMKWEk+44F/zzRpCIQeAB6mi4pfS9hCmEGg0af5k6Wo91Oc52YOFEhbsSe24yP4/5Sa6PivvHDSGgW/wOtk4IBtJvoRyDL1Teq+PgcL7tROSKu8H0r/bRC9YkJNmWnSd3gC68Ov701gGZkJ9e4XWyo0pM9K3UVoAuomUhe2fqWXINxgwccYf6uTitwmUyAidYO1kuMW6nEMNdokIzj3I6eVLJBfWTZ5g8iIHckzn3X5XrropOdzNNfNijFIGDv9C6IgzdixYveyOtargUOYUSlWkr8H5zzwvqVqm5Hfnt6fVwDAxrLXmCe3X8RmPCdIuNB9mZK3aKdCK41rcnUzipq5xH4Z8dOeXVLA4VQRJc+I8Nl3kpQPU566D9xBlO4rnxClAD+1xUNi8y2HIQ6qW930UoQOtiAfrQKTeCl1wRaU8BMG200T9U2oo/um5+JkiatC8wza8qg+dev7b11TK+F/ApK/9xWRXegSgqQyUO5aFMy/qFdEq3M7dWF+2oZxtsdQheGeZfi9bzs2E8Kt+DB55e0WN25c2biVoHYC9GO2VWmog/4d65i5R4F8dv3pTexlY8dbAxw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c2c7c4-47d9-42c9-c909-08db50bd5a0f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 18:43:59.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYkyvM09spg9ZTX/7JWpWs3PWCawiTYfKz/rz5HEDhhW+lWPBm+kJzzvvEq0RIGVqBXQOCmrRQb23hrP8RKXZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_12,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090156
X-Proofpoint-ORIG-GUID: 1Bbv5074UlatPYp-Pvu9yebc-rp83fqN
X-Proofpoint-GUID: 1Bbv5074UlatPYp-Pvu9yebc-rp83fqN
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 02/05/2023 04:40, Alexei Starovoitov wrote:
> Alan,
> 
> wdyt on below?
>

apologies, missed this; see below..

> On Thu, Apr 27, 2023 at 4:35 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>> On Tue, Apr 25, 2023 at 5:13 AM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Mon, Apr 24, 2023 at 9:12 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>
>>>> The kernel will panic as follows when attaching fexit to mm_init,
>>>>
>>>> [   86.549700] ------------[ cut here ]------------
>>>> [   86.549712] BUG: kernel NULL pointer dereference, address: 0000000000000078
>>>> [   86.549713] #PF: supervisor read access in kernel mode
>>>> [   86.549715] #PF: error_code(0x0000) - not-present page
>>>> [   86.549716] PGD 10308f067 P4D 10308f067 PUD 11754e067 PMD 0
>>>> [   86.549719] Oops: 0000 [#1] PREEMPT SMP NOPTI
>>>> [   86.549722] CPU: 9 PID: 9829 Comm: main_amd64 Kdump: loaded Not tainted 6.3.0-rc6+ #12
>>>> [   86.549725] RIP: 0010:check_preempt_wakeup+0xd1/0x310
>>>> [   86.549754] Call Trace:
>>>> [   86.549755]  <TASK>
>>>> [   86.549757]  check_preempt_curr+0x5e/0x70
>>>> [   86.549761]  ttwu_do_activate+0xab/0x350
>>>> [   86.549763]  try_to_wake_up+0x314/0x680
>>>> [   86.549765]  wake_up_process+0x15/0x20
>>>> [   86.549767]  insert_work+0xb2/0xd0
>>>> [   86.549772]  __queue_work+0x20a/0x400
>>>> [   86.549774]  queue_work_on+0x7b/0x90
>>>> [   86.549778]  drm_fb_helper_sys_imageblit+0xd7/0xf0 [drm_kms_helper]
>>>> [   86.549801]  drm_fbdev_fb_imageblit+0x5b/0xb0 [drm_kms_helper]
>>>> [   86.549813]  soft_cursor+0x1cb/0x250
>>>> [   86.549816]  bit_cursor+0x3ce/0x630
>>>> [   86.549818]  fbcon_cursor+0x139/0x1c0
>>>> [   86.549821]  ? __pfx_bit_cursor+0x10/0x10
>>>> [   86.549822]  hide_cursor+0x31/0xd0
>>>> [   86.549825]  vt_console_print+0x477/0x4e0
>>>> [   86.549828]  console_flush_all+0x182/0x440
>>>> [   86.549832]  console_unlock+0x58/0xf0
>>>> [   86.549834]  vprintk_emit+0x1ae/0x200
>>>> [   86.549837]  vprintk_default+0x1d/0x30
>>>> [   86.549839]  vprintk+0x5c/0x90
>>>> [   86.549841]  _printk+0x58/0x80
>>>> [   86.549843]  __warn_printk+0x7e/0x1a0
>>>> [   86.549845]  ? trace_preempt_off+0x1b/0x70
>>>> [   86.549848]  ? trace_preempt_on+0x1b/0x70
>>>> [   86.549849]  ? __percpu_counter_init+0x8e/0xb0
>>>> [   86.549853]  refcount_warn_saturate+0x9f/0x150
>>>> [   86.549855]  mm_init+0x379/0x390
>>>> [   86.549859]  bpf_trampoline_6442453440_0+0x23/0x1000
>>>> [   86.549862]  mm_init+0x5/0x390
>>>> [   86.549865]  ? mm_alloc+0x4e/0x60
>>>> [   86.549866]  alloc_bprm+0x8a/0x2e0
>>>> [   86.549869]  do_execveat_common.isra.0+0x67/0x240
>>>> [   86.549872]  __x64_sys_execve+0x37/0x50
>>>> [   86.549874]  do_syscall_64+0x38/0x90
>>>> [   86.549877]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>>
>>>> The reason is that when we attach the btf id of the function mm_init we
>>>> actually attach the mm_init defined in init/main.c rather than the
>>>> function defined in kernel/fork.c. That can be proved by parsing
>>>> /sys/kernel/btf/vmlinux:
>>>>
>>>> [2493] FUNC 'initcall_blacklist' type_id=2477 linkage=static
>>>> [2494] FUNC_PROTO '(anon)' ret_type_id=21 vlen=1
>>>>         'buf' type_id=57
>>>> [2495] FUNC 'early_randomize_kstack_offset' type_id=2494 linkage=static
>>>> [2496] FUNC 'mm_init' type_id=118 linkage=static
>>>> [2497] FUNC 'trap_init' type_id=118 linkage=static
>>>> [2498] FUNC 'thread_stack_cache_init' type_id=118 linkage=static
>>>>
>>>> From the above information we can find that the FUNCs above and below
>>>> mm_init are all defined in init/main.c. So there's no doubt that the
>>>> mm_init is also the function defined in init/main.c.
>>>>
>>>> So when a task calls mm_init and thus the bpf trampoline is triggered it
>>>> will use the information of the mm_init defined in init/main.c. Then the
>>>> panic will occur.
>>>>
>>>> It seems that there're issues in btf, for example it is unnecessary to
>>>> generate btf for the functions annonated with __init. We need to improve
>>>> btf. However we also need to change the function defined in
>>>> kernel/fork.c to task_mm_init to better distinguish them. After it is
>>>> renamed to task_mm_init, the /sys/kernel/btf/vmlinux will be:
>>>>
>>>> [13970] FUNC 'mm_alloc' type_id=13969 linkage=static
>>>> [13971] FUNC_PROTO '(anon)' ret_type_id=204 vlen=3
>>>>         'mm' type_id=204
>>>>         'p' type_id=197
>>>>         'user_ns' type_id=452
>>>> [13972] FUNC 'task_mm_init' type_id=13971 linkage=static
>>>> [13973] FUNC 'coredump_filter_setup' type_id=3804 linkage=static
>>>> [13974] FUNC_PROTO '(anon)' ret_type_id=197 vlen=2
>>>>         'orig' type_id=197
>>>>         'node' type_id=21
>>>> [13975] FUNC 'dup_task_struct' type_id=13974 linkage=static
>>>>
>>>> And then attaching task_mm_init won't panic. Improving the btf will be
>>>> handled later.
>>>
>>> We're not going to hack the kernel to workaround pahole issue.
>>> Let's fix pahole instead.
>>> cc-ing Alan for ideas.
>>
>> Any comment on it, Alan ?
>> I think we can just skip generating BTF for the functions in
>> __section(".init.text"),  as these functions will be freed after
>> kernel init. There won't be use cases for them.
>>

won't the pahole v1.25 changes help here; can you try applying

https://lore.kernel.org/bpf/1675949331-27935-1-git-send-email-alan.maguire@oracle.com/

...and build using pahole; this should eliminate any functions
with inconsistent prototypes via

      --skip_encoding_btf_inconsistent_proto
        Do not encode functions with multiple inconsistent prototypes or
        unexpected register use for their parameters, where  the  regis‐
        ters used do not match calling conventions.


I'll check this at my end too.

Alexei, if this works should we look at applying the above
again to bpf-next? If so I'll resend the patch.

Thanks!

Alan

>> --
>> Regards
>> Yafang

