Return-Path: <bpf+bounces-540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC7A7030A1
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 16:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA6F1C20BE2
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D678ED2F3;
	Mon, 15 May 2023 14:54:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FEC2FD
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 14:54:40 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D0510C9
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 07:54:38 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FDFvdD004351;
	Mon, 15 May 2023 14:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4YGTo5tIhuEhLbfIJZ8+4y6aDo+72w4qSsPivG4HQ/8=;
 b=IKt2KGMEm7CTjLL4+pmYYwdQaFZLpc/Z70JF7muQEtA4GHcu0pEtefHoEfiR9/IjEdzP
 jJZQ9GP+RdIzMntNJ+G1qaKtCi/8pz9QedhbxvJOVyLMlX06/J1YKrf3wEajx6Z8Rr9z
 Mxo/PAedLE0mBJsTyr5q2DvIQ7OPlMvbQ434xwS6bdXNuzzXcphRFqpW798uYfBICF5Q
 1VSxjFky/MF1zNYHR4xE7R9/yxs8d6Gp2tqggJLLKmBIih1rzQ5q5eFZuZ6fzB1fq0GL
 5TmlW0t2hYm3/pcVCNlPxhOm54/4RotWdH7I67s5rcQvultigYBQH8cDCUuhCNOafCsW yQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc07r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 May 2023 14:54:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FDdkAt022984;
	Mon, 15 May 2023 14:54:11 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj102hcv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 May 2023 14:54:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNyw/HykX1wbFQWAnfnJhVbvArUYLsbxhxPZpfRF+zW3S/UNOmGMFlSxJW/HFxTq4R8ZzGhh+chzvNoFrAElcLZvpaGbj7lF9O7gRcjKVawt9GAAidZeWbWgKqEuoyeVps/rEnMAIjrfAkADp9IQQVc4iLTb4ncSw4pC8BD7umcE/857eTw0QpgDBrXOAzuVt8TTrXadwR4/3w6vm3xbDI9+C1VuVwoXDNTGuc5zM3+TSi3Xi3ry8L5DUXotKKwjVH90cVdMCb/Tmm8xVgFsVBT72KdmmRxFiy1PxmkF16eY8+Idu2nPX4U7gAaHmSAlDksVNnurDzgjD1jxV9QgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YGTo5tIhuEhLbfIJZ8+4y6aDo+72w4qSsPivG4HQ/8=;
 b=n1EGhLNXm7y3NZQzjOtZuhtnr9QGU5UscyhD6aQFa9GLfqzd8UeemT2TwLdIpj0hyA89gnJsIW7CkIocrc9zth225sEG+SAG2yA6nU7LqwtOI+bp/BIBtO2EA81m9hCCHvRiuwbYsIoFROjlrMBIZWu6+1sUdyYaspZ8Rve8GJWaYaOYfod9E9Q7teVqJQjz98y9QqEjcQeJ8kX/N8uy4Hjej9kFoV+UsNjTVsq0z/O5WERn4fBawKq7rJWJIiYG6fDoGjIbKVdef3DFGEaaC/9NoaPwsxpg6NODUPP6SbjuUUCXO68++AZXpodZJS5Ql4oCqFYGYAdFrzMX+v6HSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YGTo5tIhuEhLbfIJZ8+4y6aDo+72w4qSsPivG4HQ/8=;
 b=tfC5O18SQbIDskCodlZke45w5KdEm5kly6grgyraOTJ1eUOl1fp1TkJmAMJqYI50P9OIXWhhLC8sI8/JCIRSF9XqBA0dtjQV3PJYQ6hIYTzzpwuVyEa398wiV/23AwgLXdCabwGqnLKBjMNQkRKw2ex1DlA/JV1JMGCeSkm9UjY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB4727.namprd10.prod.outlook.com (2603:10b6:510:3f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:54:08 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:54:07 +0000
Message-ID: <deb2c59f-20a1-a849-6ad5-b4e09d6f6f85@oracle.com>
Date: Mon, 15 May 2023 15:53:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next] bpf: Add --skip_encoding_btf_inconsistent_proto,
 --btf_gen_optimized to pahole flags for v1.25
Content-Language: en-GB
To: Yonghong Song <yhs@meta.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>, Lorenz Bauer <lmb@isovalent.com>,
        Timo Beckers <timo@incline.eu>
References: <20230510130241.1696561-1-alan.maguire@oracle.com>
 <CALOAHbDeK4SkP7pXdBWJ6Omwq2NyxJrYn6wZTX=z1-VkDtWwMQ@mail.gmail.com>
 <6b15f6ff-8b66-3a78-2df6-5def5cf77203@oracle.com>
 <CAADnVQKDO8_Hnotf40iHLD-GRmJZpz_ygpkYZGRvey0ENJOc0g@mail.gmail.com>
 <ZF61j8WJls25BYTl@krava> <278ac187-58ea-7faf-be2d-224886404ea2@meta.com>
 <49e4fee2-8be0-325f-3372-c79d96b686e9@meta.com> <ZGFXdAs2dzQiPHq8@krava>
 <76d62c3a-af8c-bd6d-abe7-8f8ead0a828d@meta.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <76d62c3a-af8c-bd6d-abe7-8f8ead0a828d@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0151.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB4727:EE_
X-MS-Office365-Filtering-Correlation-Id: da4ca4ea-f8c5-47de-5329-08db55543bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EaX44ZfbY0sf1O+gGAUCmRo3anlKLBXD7EgjtbtgC6Hq1a7qRy3sqPspRCbpxBKpDvRB2EoMEhw0GTQT0qXUDwQ4GBbgyZhrYgd8fA+g25UqE18jQ6XWZqCC20aK3/6uugE9cq+w4Cxg17H+kLmjAo2FniOVsu3RQNA2fhY3ZzYzq+x6uEHwX3ZgK8F6SIkLgC69DbKFRorNCGQ9ac5t9d0yAfuzNZptDtlS1xBu4PY5tw7fRayrEVaG4Uo/mA4OjdTdV9Wybv9g4CdCIClj1svQR63alLYbmW4Fk9Fj3kv7y116YLSB63XvRaMP2dsHBjjDSubf0gZ/udiLAEdfFrDJEdjn72Mq97GSXQRteYl7SXSWTKvhZu1BAl6pODshFNLVewRijTt2/Ndz/ZjBBLRiUvLnYR74vkvr1C6wtQBr7ohdY0t701HvxS/mjh3Tqq0D4hVb6M9kTaJQ2Eyh/FItBINjdv4B9cltR6lIeCaK3fZTDCE0wtWARBRdVn+jZYKUJBtc/iTCoO8WW9JMzGruKFsud5tl26cUyVBrzMgrBiPjkv06yoTGv1Scp8D+qogDpjcttye/AajOzDt9zSgofv6MEaZq6jxs2vRpHf42oReKh2+05MsBwnW2jvVqEIbdkJ8spGz919SezPxj5Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(6506007)(53546011)(6512007)(478600001)(54906003)(110136005)(6666004)(7416002)(186003)(30864003)(44832011)(86362001)(8676002)(8936002)(5660300002)(2906002)(31696002)(36756003)(41300700001)(4326008)(316002)(38100700002)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RjN2ak9rQ1RlcG02b2U2aFF6Q3NTZUZ6cjJwaXN6aEJZRjl6YmJucXFsSWRQ?=
 =?utf-8?B?dWVIZTlTRUJ1bWpjazhwQloyWEFPUzRKK2ZYWGgvdTlxOTNlM0VwOWgzUkxX?=
 =?utf-8?B?Nkw3RHl6MURraXZpNWh2VXBNY3JhcmJpaGY0OVVKZC8ranZpb2duTFdhVEMr?=
 =?utf-8?B?cUtYbGdXRDJLWHJ4NHY4U2dtMWNNcHh2SlFnaWFNUWJqQy80S0hiTGEyMHcw?=
 =?utf-8?B?LzBoeEM3MCtpRmhua2ltdmJzOGUrWmgwOHR4dWlJZFNiNURXUnFaU0czUERK?=
 =?utf-8?B?YXNYK094Y0tFaFBBL3ZqTG9jazNtSmN1M1NoM1k0UDFxTTZQWEJpTm4xME8x?=
 =?utf-8?B?Q01NRW9tYVV4Rm52K3RHOWVzNWdZNFdZLy9uNG5XRnRSN2NvQTR3ZUkxano5?=
 =?utf-8?B?K1AvcFFPNlh1a0ZrMGtMSzg3RjRieUhaZnlHRmdGbktubngzbHZEM2g5ZUFq?=
 =?utf-8?B?MjVTQzlQQ2tBeFpUTnVCRFlTWDhROGFOQjJzK2ZualNxRmp1d0ZOWTk1MUZ4?=
 =?utf-8?B?dzhaVVBpMmJ0dGJ0K3BEKy9jaE1telovUkFrSTBrdzkxdWxaWUFDNHZIdEc5?=
 =?utf-8?B?RnRIZVVYYmdEOFNYZmlFZ1NMOUpyVUh4MzdIWDdSajd6dG9ORUFPZkZOZ3p1?=
 =?utf-8?B?S200djZseFk3UE93NlZDNHZid1RJOXNlL3JxTnRBNEhiOWFnSGVaY3hxL3JI?=
 =?utf-8?B?aWMrWCtINHlNb1gzL3lMRWovZmErblRYVmhDenNRZzRGb3Q5d3VjVkFHVDdR?=
 =?utf-8?B?SkZTWG4vZkl4c0NXWGFnZnM5WFJ3aFBkQUJBSE1HWXVqQ1hHVDY2QTZRWDJJ?=
 =?utf-8?B?aWJzYTNxcGlFdXpRSHZoZW4rWTZRNkVzamVSdEIxTG50T1o2S24vWVZJc1JX?=
 =?utf-8?B?NTFGa2hnczZTOWZEWWRnL2JyUVovVTFLUkJGZ0c5YzR3VkJURGZQb25EUHgr?=
 =?utf-8?B?TUlLQXBIMHV4ejVXWk1VanhrVW9Cb1FCak5hOW9vWHQvV05oSjJIRWVTYjBG?=
 =?utf-8?B?VjhrSWlNeXFtMUw5NC9ob2RXNWpIQnRBVXNPUFJhSXR0MlA1Y2pIY0ZleTZW?=
 =?utf-8?B?em5GNlRQYy9EYU83bFU2U09NMVJ6Y3d0WmxrQjc2UWZQaWtOVHNBajlkdXVL?=
 =?utf-8?B?eldsYnZkTGJZY1p2RVd5WkREbiticTk1amEza2NYc2FQTVBodTdzWTBmakxr?=
 =?utf-8?B?cEZIcXpZRS9EbFJCKytZdlF3N08wQ3FNZXcybW5FTkRqMTc3WVFVRjVVVWRF?=
 =?utf-8?B?ZWw5UUV2Vm9jRmVQVXJKc29keXUxa0d6VlhObUJYVTNwU201ZnRhWTBQSkhO?=
 =?utf-8?B?SzByZlJnT3FocGdva3phbTF1dXk1a01tTmhOa2FSRHppNnVoV2FhV2w1RVpx?=
 =?utf-8?B?WDZKWHZkak10TUdVQ2pyVkFKQldLRUFGS0gyRlBaUno3S0tENW1MMEgzVmE0?=
 =?utf-8?B?R2pmYUdWMnhLMHRoUit2WE5ySWx3VFBZS0tWMlNXcFkvQlZtME1Wcm4wN25G?=
 =?utf-8?B?R3V6UmJJbU0yM0laZ1pFUFZEVGo0SUVraGhKYU0zS0R4dENFREpsVTFwWm9h?=
 =?utf-8?B?ZjlOUmxJbDZTOElHK3pqc2ZrZ0RnK0Q1UEN0QlBvSEJFeGdETk00MitZN1pH?=
 =?utf-8?B?WUk4TWRYbjBmeVBpT2Qwc2tockhyNkdmRzFvaFEyK0ltMUQ4emJSUWJkQnVE?=
 =?utf-8?B?eGxKR2d4b1VUem9YUjNGS3Q2UWJkd2RmSStOYWNmR0R2Y3hVUnhCUmhxd3ZV?=
 =?utf-8?B?NXNnaGxmSG1NYUEzcm9RV2ZscEg0NmxjWmtDTEgwY2crQk5wOGg3WVZnUkJi?=
 =?utf-8?B?eTJuOHZvamltWVZ2dGxQck0xYi94T05aS0F1MmNrS0NtVXQwd0JXS1V1RHcx?=
 =?utf-8?B?UzJPMlpWZWtyT3RKL0phK081eHZDZDZ3b2RNY3d4VEdHSHhNdE5aSHFYS2M2?=
 =?utf-8?B?bnBpdlI5UzJUa2JBR01CbU4vMTI2TzNhaG1jQUVDZTJTTmFmbVFmVGxKcEp2?=
 =?utf-8?B?L3d0c2kzTXFXbkVrbSt4K0d3WVhiUFh0U2pWck5NV3ViOXZUZXR5Nk95Myt0?=
 =?utf-8?B?NldObFZYSEJLRlhvMHlGbXRIN3pyZUx4VldPdTNCVVo3SkMvcWNXK2IzVC9k?=
 =?utf-8?B?NGlwTXBObzVZbVBNR2JFWW1UaTMvamQ0SkJwaHJQSkc0L1o3Y3JCcm1xZ092?=
 =?utf-8?Q?pPtSdkD/T0A6Ko4cP9Z2FSo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?ZEowMnpuUC9qakU4SXltVUIrVnVUcDBSNzZLUjBqUG9VVjBnMjRwdXZPdmJp?=
 =?utf-8?B?U1hyZ1R4MWg2MlA4eTF4WjZLVWk1WWJyL1dKSWpFbUxsZzBzb1NjbVFrK0h4?=
 =?utf-8?B?YjJNd2hoZERzN1JsNlZKL0RzNm1GZmpXTmpDWDIxVGFWeUdDWjhrcHg2VFdk?=
 =?utf-8?B?VTJQamRQK29meXowQVdSK2s0eXlJQnVQeFZpb0FLaHVsR2c1SFBWZW5OOThq?=
 =?utf-8?B?NmRLWU9JbnBTZ0dOOE1xKzNWMHZkSEdjdG95N0VpNjJ2S2ltdFJQa3B3M1FF?=
 =?utf-8?B?YzdkQlArL3lsMWNFell2K3ptUEI5NGp0d3pjTjFKYmdtNmhxT2lUemJBOVlO?=
 =?utf-8?B?V1laZ0YxNTF1UHBmRUVpSUlkY1hSSy9XSFpwL3hlTTNhS0xnN0F1eGpPQnZY?=
 =?utf-8?B?ZlYyRkhUM3dJa1ZGQU1oVnMxU3JueSsxMW1SM000NlBya0Q0K0FGK1hYRlFm?=
 =?utf-8?B?Z1lJQTVjR21tM1M5eGZ6LzZPdEkrbmlaK2F3ak5VVkZZeEpHZlZPVUtRRk1E?=
 =?utf-8?B?SnZ0TWpSQVVWMU1PM3RCZFZVQW5kRDRlU2xSZkNTSnc1WXUrWmtBMjNwTmRT?=
 =?utf-8?B?bUdoaFRkSTlWY2xsd2R5ZW1oVG9zREM4VkhZaE44dnFncmkwNysvUEpOTkNh?=
 =?utf-8?B?ZWIrQVY3cU1EVWhGMmNjOUlOY2tEdkd3OUYweTBBbENmSVlJSmI2LzQ3Tk01?=
 =?utf-8?B?MFBmOGlVRk53aHNkeTN0NlMyZDhSQms1R1kxZzhYVmZHZnU0TUR5YnZBcDhu?=
 =?utf-8?B?MGc3aXl4Q3U2SU45NzNnSzRGc2dQaHNtZmk5ZWxMWnBEUTlBa2FEOUkvcDl2?=
 =?utf-8?B?Zkc5SnB2eGZHaENzTFA0SU5DZnZ4VnA3Q2Z1QUJqQmdPYTVsT0N0TVpuZ0Rs?=
 =?utf-8?B?WmVNc09QZnVtQnp5OStBcm1wd1JyQXN4Sk5mNG5rRGVIS1VnVyt3VjdqMnFt?=
 =?utf-8?B?dURSNVNQVUhpL3BES2twQzJwdTJUbmk5bnpJMTN5ajdHeitDNGdZQytjL2hl?=
 =?utf-8?B?WTFITjdFMjVKVmZMWXNGdFJOZjVLRW1TMkhRZmtVTE1Saks1MVF1SE1BaW9Z?=
 =?utf-8?B?U0J0bUZsQVM5MVZPNU1kSDB3eVIvYi9ZeUZ4RUMxM1hKMVl6WXNIWmN3L28v?=
 =?utf-8?B?b3FGUHRQQ3dDY25SSFVEWE1venE5bHhkZDR0a0Y1Zjg5STFveUJkWXdXc3g1?=
 =?utf-8?B?L3poZkxKOTNxQzVqQVA5NDlHYnBhUklLQjVuYlRWSXBVYWgwUEJqdkZUbncr?=
 =?utf-8?B?UzhuTFdTVC9QZ3VoWFA5eDVLT0JNZjAwaGFSc0VpUXRjam0wYit3OHd4dWF1?=
 =?utf-8?B?OTh2VTlNS3RUMWp5clZ0Q0NnRnYxYVNjbXJFc2F6WDcyZXljNkFIWUxtb1l5?=
 =?utf-8?B?ZkVsZDFVVERlWUE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4ca4ea-f8c5-47de-5329-08db55543bc1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:54:07.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyHk56rJpFXCAlJmR0+ly2hg1nHQ7VBu7H/6il8sd5SHjorK6Ol8CJFdpu/ZY04fUZoo2FuHs+qjF+sG23gwrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150122
X-Proofpoint-ORIG-GUID: _DqAveNjj9Nc9ePUoPlcpWTW_BJ-O97b
X-Proofpoint-GUID: _DqAveNjj9Nc9ePUoPlcpWTW_BJ-O97b
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 15/05/2023 05:06, Yonghong Song wrote:
> 
> 
> On 5/14/23 2:49 PM, Jiri Olsa wrote:
>> On Sun, May 14, 2023 at 10:37:08AM -0700, Yonghong Song wrote:
>>>
>>>
>>> On 5/12/23 7:59 PM, Yonghong Song wrote:
>>>>
>>>>
>>>> On 5/12/23 2:54 PM, Jiri Olsa wrote:
>>>>> On Fri, May 12, 2023 at 11:59:34AM -0700, Alexei Starovoitov wrote:
>>>>>> On Fri, May 12, 2023 at 9:04 AM Alan Maguire
>>>>>> <alan.maguire@oracle.com> wrote:
>>>>>>>
>>>>>>> On 12/05/2023 03:51, Yafang Shao wrote:
>>>>>>>> On Wed, May 10, 2023 at 9:03 PM Alan Maguire
>>>>>>>> <alan.maguire@oracle.com> wrote:
>>>>>>>>>
>>>>>>>>> v1.25 of pahole supports filtering out functions
>>>>>>>>> with multiple inconsistent
>>>>>>>>> function prototypes or optimized-out parameters from
>>>>>>>>> the BTF representation.
>>>>>>>>> These present problems because there is no
>>>>>>>>> additional info in BTF saying which
>>>>>>>>> inconsistent prototype matches which function
>>>>>>>>> instance to help guide attachment,
>>>>>>>>> and functions with optimized-out parameters can lead
>>>>>>>>> to incorrect assumptions
>>>>>>>>> about register contents.
>>>>>>>>>
>>>>>>>>> So for now, filter out such functions while adding
>>>>>>>>> BTF representations for
>>>>>>>>> functions that have "."-suffixes (foo.isra.0) but
>>>>>>>>> not optimized-out parameters.
>>>>>>>>> This patch assumes that below linked changes land in
>>>>>>>>> pahole for v1.25.
>>>>>>>>>
>>>>>>>>> Issues with pahole filtering being too aggressive in
>>>>>>>>> removing functions
>>>>>>>>> appear to be resolved now, but CI and further testing will
>>>>>>>>> confirm.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>>>>>> ---
>>>>>>>>>    scripts/pahole-flags.sh | 3 +++
>>>>>>>>>    1 file changed, 3 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
>>>>>>>>> index 1f1f1d397c39..728d55190d97 100755
>>>>>>>>> --- a/scripts/pahole-flags.sh
>>>>>>>>> +++ b/scripts/pahole-flags.sh
>>>>>>>>> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
>>>>>>>>>           # see PAHOLE_HAS_LANG_EXCLUDE
>>>>>>>>>           extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
>>>>>>>>>    fi
>>>>>>>>> +if [ "${pahole_ver}" -ge "125" ]; then
>>>>>>>>> +       extra_paholeopt="${extra_paholeopt}
>>>>>>>>> --skip_encoding_btf_inconsistent_proto
>>>>>>>>> --btf_gen_optimized"
>>>>>>>>> +fi
>>>>>>>>>
>>>>>>>>>    echo ${extra_paholeopt}
>>>>>>>>> -- 
>>>>>>>>> 2.31.1
>>>>>>>>>
>>>>>>>>
>>>>>>>> That change looks like a workaround to me.
>>>>>>>> There may be multiple functions that have the same proto, e.g.:
>>>>>>>>
>>>>>>>>     $ grep -r "bpf_iter_detach_map(struct bpf_iter_aux_info \*aux)"
>>>>>>>> kernel/bpf/ net/core/
>>>>>>>>     kernel/bpf/map_iter.c:static void bpf_iter_detach_map(struct
>>>>>>>> bpf_iter_aux_info *aux)
>>>>>>>>     net/core/bpf_sk_storage.c:static void
>>>>>>>> bpf_iter_detach_map(struct
>>>>>>>> bpf_iter_aux_info *aux)
>>>>>>>>
>>>>>>>>     $ bpftool btf dump file /sys/kernel/btf/vmlinux   |  grep -B 2
>>>>>>>> bpf_iter_detach_map
>>>>>>>>     [34691] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
>>>>>>>>     'aux' type_id=2638
>>>>>>>>     [34692] FUNC 'bpf_iter_detach_map' type_id=34691 linkage=static
>>>>>>>>
>>>>>>>> We don't know which one it is in the BTF.
>>>>>>>> However, I'm not against this change, as it can avoid some issues.
>>>>>>>>
>>>>>>>
>>>>>>> In the above case, the BTF representation is consistent though.
>>>>>>> That is, if I attach fentry progs to either of these functions
>>>>>>> based on that BTF representation, nothing will crash.
>>>>>>>
>>>>>>> That's ultimately what those changes are about; ensuring
>>>>>>> consistency in BTF representation, so when a function is in
>>>>>>> BTF we can know the signature of the function can be safely
>>>>>>> used by fentry for example.
>>>>>>>
>>>>>>> The question of being able to identify functions (as opposed
>>>>>>> to having a consistent representation) is the next step.
>>>>>>> Finding a way to link between kallsyms and BTF would allow us to
>>>>>>> have multiple inconsistent functions in BTF, since we could map
>>>>>>> from BTF -> kallsyms safely. So two functions called "foo"
>>>>>>> with different function signatures would be okay, because
>>>>>>> we'd know which was which in kallsyms and could attach
>>>>>>> safely. Something like a BTF tag for the function that could
>>>>>>> clarify that mapping - but just for cases where it would
>>>>>>> otherwise be ambiguous - is probably the way forward
>>>>>>> longer term.
>>>>>>>
>>>>>>> Jiri's talking about this topic at LSF/MM/BPF this week I believe.
>>>>>>
>>>>>> Jiri presented a few ideas during LSFMMBPF.
>>>>>>
>>>>>> I feel the best approach is to add a set of addr-s to BTF
>>>>>> via a special decl_tag.
>>>>>> We can also consider extending KIND_FUNC.
>>>>>> The advantage that every BTF func will have one or more addrs
>>>>>> associated with it and bpf prog loading logic wouldn't need to do
>>>>>> fragile name comparison between btf and kallsyms.
>>>>>> pahole can take addrs from dwarf and optionally double check
>>>>>> with kallsyms.
>>>>>
>>>>> Yonghong summed it up in another email discussion, pasting it in here:
>>>>>
>>>>>     So overall we have three options as kallsyms representation now:
>>>>>       (a) "addr module:foo:dir_a/dir_b/core.c"
>>>>>       (b) "addr module:foo"
>>>>>       (c) "addr module:foo:btf_id"
>>>>>
>>>>>     option (a):
>>>>>       'dir_a/dir_b/core.c' needs to be encoded in BTF.
>>>>>       user space either check file path or func signature
>>>>>       to find attach_btf_id and pass to the kernel.
>>>>>       kernel can find file path in BTF and then lookup
>>>>>       kallsyms to find addr.
>>>>>

I like the source-centric nature of this, but the only
danger here is we might not get a 1:1 mapping between
source file location and address; consider the case
of a static inline function in a .h file which doesn't
get inlined. It could have multiple addresses associated
with the same source. For example:

static inline void __list_del_entry(struct list_head *entry)
{
	if (!__list_del_entry_valid(entry))
		return;

	__list_del(entry->prev, entry->next);
}

$ grep __list_del_entry /proc/kallsyms
ffffffff982cc5c0 t __pfx___list_del_entry
ffffffff982cc5d0 t __list_del_entry
ffffffff985b0860 t __pfx___list_del_entry
ffffffff985b0870 t __list_del_entry
ffffffff9862d800 t __pfx___list_del_entry
ffffffff9862d810 t __list_del_entry
ffffffff987d3dd0 t __pfx___list_del_entry
ffffffff987d3de0 t __list_del_entry
ffffffff987f37a0 T __pfx___list_del_entry_valid
ffffffff987f37b0 T __list_del_entry_valid
ffffffff989fdd10 t __pfx___list_del_entry
ffffffff989fdd20 t __list_del_entry
ffffffff99baf08c r __ksymtab___list_del_entry_valid
ffffffffc12da2e0 t __list_del_entry	[bnep]
ffffffffc12da2d0 t __pfx___list_del_entry	[bnep]
ffffffffc092d6b0 t __list_del_entry	[videobuf2_common]
ffffffffc092d6a0 t __pfx___list_del_entry	[videobuf2_common]

>>>>>     option (b):
>>>>>       "addr" needs to be encoded in BTF.
>>>>>       user space checks func signature to find
>>>>>       attach_btf_id and pass to the kernel.
>>>>>       kernel can find addr in BTF and use it.
>>>>>

This seems like the safest option to me. Ideally we wouldn't
need such information for every function - only ones with
multiple sites and ambiguous signatures - but the problem
is a function could have the same name in a kernel and
a module too. So it seems like we're stuck with providing
additional info to clarify which signature goes with which
function for each static function.

>>>>>     option (c):
>>>>>       if user can decide which function to attach, e.g.,
>>>>>       through func signature, then no BTF encoding
>>>>>       is necessary. attach_btf_id is passed to the
>>>>>       kernel and search kallsyms to find the matching
>>>>>       btf_id and 'addr' will be available then.
>>>>>
>>>>>     For option (b) and (c), user space needs to check
>>>>>     func signature to find which btf_id to use. If
>>>>>     same-name static functions having the identical
>>>>>     signatures, then user space would have a hard time
>>>>>     to differentiate. I think it should be very
>>>>>     rare same-name static functions in the kernel will have
>>>>>     identical signatures. But if we want 100% correctness,
>>>>>     we may need file path in which case option (a)
>>>>>     is preferable.
>>>>
>>>> As Alexei mentioned in previous email, for such a extreme case,
>>>> if user is willing to go through extra step to check dwarf
>>>> to find and match file path, then (b) and (c) should work
>>>> perfectly as well.
>>>
>>> Okay, it looks like this is more complex if the function signature is
>>> the same. In such cases, current BTF dedup will merge these
>>> functions as a single BTF func. In such cases, we could have:
>>>
>>>     decl_tag_1   ----> dedup'ed static_func
>>>                           ^
>>>                           |
>>>     decl_tag_2   ---------
>>>
>>> For such cases, just passing btf_id of static func to kernel
>>> won't work since the kernel won't be able to know which
>>> decl_tag to be associated with.
>>>
>>> (I did a simple test with vmlinux, it looks we have
>>>   issues with decl_tag_1/decl_tag_2 -> dedup'ed static_func
>>>   as well since only one of decl_tag survives.
>>>   But this is a different issue.
>>> )
>>>
>>> So if we intend to add decl tag (addr or file_path), we
>>> should not dedup static functions or generally any functions.
>>
>> I did not think functions would be dedup-ed, they are ;-) with the
>> declaration tags in place we could perhaps switch it off, right?
> 
> That is my hope too. If with decl tag func won't be dedup'ed,
> then we should be okay. In the kernel, based on attach_btf_id,
> through btf, kernel can find the corresponding decl tag (file path
> or addr) or through attach_btf_id itself if the btf id is
> encoded in kallsym entries.
> 
>>
>> or perhaps I can't think of all the cases we need functions dedup for,
>> so maybe the dedup code could check also the associated decl tag when
>> comparing functions
>>

Would using the BTF decl tag id instead of the function BTF id to
guide attachment be an option? That way if multiple functions shared
the same signature, we could still get the info to figure out which to
attach to from the decl tag, and we wouldn't need to mess with dedup.
I'm probably missing something which makes that unworkable, but just a
thought. Thanks!

Alan

