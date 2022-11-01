Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C082A614EBF
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 17:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKAQCZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAQCY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 12:02:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A33CE07
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 09:02:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1F4EHG009892;
        Tue, 1 Nov 2022 16:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1w3C7Q8mdzm0ZrkSUQaLRAbnH04EVS1ws5H6kK8iU7M=;
 b=FW8WGyyw86fTFYk89lhHNZuTRVUU9RjqxvCXAxu0ADKfTn1w/W8VvEC7Pq+ah9A4rByG
 6wfs78vEqqX9vjDgsXywpmfEraDvMCL/Lv0w068cDlcisjTfPj9p1W/zQNxzqilV9guM
 ZCXGA+xzcM7OIXLXEezs/VsboMj06AFF7kkQRlEbFgX4E1IALl6ZKSmiXkD+FX2scs0H
 klPlTy0xQkv4QYNr/d374KNbFJwIcRmfDXnTkktnpCxmO711NS4racu/HG1NeW14ywm5
 V19hYYt3aDUOkrAuYUwVGbwI0irKqYTWlUK8Jju8bssiB6/kMtKP+liEg/cYjnTWvT09 ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtf49h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 16:02:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1Fbp0T014174;
        Tue, 1 Nov 2022 16:01:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmamvhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 16:01:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqfCQC2zbzR4JBF+acVaE/qmTEUXYjTu8KpvMQ6IsnB61VU+fHqW/Wvl0ZvpnaKIxra8T0hq5PwehC0eq5mOe+vpID0zf/Q5w3WiC1BMYl7mGsu2SFdtSaF48nqncc0npSRS2KcYSy648C02jeFfwz2zpk58ou1IT2+7WRpPGmtYKhfvXJm6ekMF2Cg0Dl5YjAwIULXYwwkzV9t4tRLnuiF4auirPIepeRQalNOQ/WCGs+eKJGAz32UvOz1RzzGmDjiiBeE99iU4CpwfcjpuvqGIDmzPJ/IRzDsSupqmPVOmhTLNSvwzenSRNvKJIRdMXR+H+0Pa+WSt/YqHQYTofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w3C7Q8mdzm0ZrkSUQaLRAbnH04EVS1ws5H6kK8iU7M=;
 b=aXuN3aIan+Z3saYBqLZ+rbGr7vpPiGRxFdwOhoMQL2RgjLUA+8NnduAjQQ0qTVEmBOzhLgmQ2E5B7NDc/QxwPutPmBlIE0M6ZHi+2PMV0+FTCroukOp/hG9Y2oMQ1Wm7b0eVVkHQDxr2jjbPk04M8fqyB/TX+LEjoIx2nBGtWQu3YEEzfB+whRnaUymFqrPHMNrR6kakqSTtn+KuUENCa632qogmSMwNnDdDX7rRkdT3xcwDGSeHVqjd2ZJTlGDbkCsNEUaWg+XwV/b+o4jFU/XWN2h5tv6DtvX9FtPaUYcYtP5xEBSzYJ0vLb0BMykR3Q9bvdW7Sww87ES24XUKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w3C7Q8mdzm0ZrkSUQaLRAbnH04EVS1ws5H6kK8iU7M=;
 b=W596TVULcpUJghn+2bVUrYMMnXEZV56Zw0TIHo58f51JhW/7dzI9LYRvREx4ftXkQkC8nk1jugBmEB8ditZjLMjxcI6VdLRORUinC0IcNnaLIJckbRTJ/st2xFuOmshBbl0hdkMYgK5NZHCZLlZWRfgFLONGAmsg7W4inNJdXgM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB4631.namprd10.prod.outlook.com (2603:10b6:510:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 16:01:57 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8e3c:584c:3f1a:7825]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8e3c:584c:3f1a:7825%6]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 16:01:57 +0000
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@meta.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com, arnaldo.melo@gmail.com
References: <20221025222802.2295103-1-eddyz87@gmail.com>
 <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
 <f62834eb-fd3f-ba55-2cec-c256c328926e@meta.com>
 <CAEf4BzYT4pwmw64DaCTxR3_QjO5RRVadqVLO0h-hNa-+xOyLZw@mail.gmail.com>
 <af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com>
 <CAEf4BzZE7boex4KBjMmhJ4Nib6BA71-pf5jiAg74FjEdr_2e6A@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <ea841d91-a43f-a6e0-e8ce-90f9b2d3f77c@oracle.com>
Date:   Tue, 1 Nov 2022 16:01:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAEf4BzZE7boex4KBjMmhJ4Nib6BA71-pf5jiAg74FjEdr_2e6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0238.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::34) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: 81884d96-fe89-439c-ed0f-08dabc2266ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKcPvzfnOActdj+AUukD3Im4MOyO1CygPmvWXvXXK7EhK8sxFKR1YiCjCOkG+rpwLzTMJRvTL4kCe3G0oQQcC1mcwJShjVZpCdMW/3Tzn/mt1vXMnBqBQZrw9nMilH0rK8ZLWYbuM4ehDzt4EcY90w6iMfRiIfDncPMla7nG0Fiopkqd8OdGii8FdyE+EPfe7Jz+Q5oyglNFoYzho17CiaFsm47nPFRltjR1uLm7ynm9f+kpiTFijBNrlThchiasVo9BCCw8Rc0pzi9gghVkfskT2r/6IrkzB+tbzk/WUuLLEFpoKMKTXXIVcGmFXT9zaM0+UmXsRcTq36jPFwaZKXptTEJ4mU2fuG2ehw2C95njJcRHcBuYlK/K+Boy0cBmrc3TxjNKFNyNkIWWUwvw+U98A7t2oNbNjkzumaLaMRM8r+4oJnaXm636ECDjNx85dwhpV4PZx7ehgWiXwu+BGqykANisbgi5nkaMT4jGSp4QmyxACSAij53SRizWQepX4AgIKSAFSkA3EmjAblbApzfyh9bhNL9v9tU/vYGNaoDPH1rAzgRzBm4aPAdMDnC5xB72LxKkGFAynMm5WeI/UWbGx0FMtV6zVRyOgEWHAiVZ8ar8NqAkR2kHlJ6mCLYbyJzIi6AYnUC7RcVAI5GuSVL+BB8OzpC7EUXFqUOWPk0c3N8dqDGMsTST4jYwY81hkfPf2Q5U3BaF2ROk+z6yztNN+BS+SMHAjL0VuJOag7sZZimHjndJMEd3BV2RemeaD4FRDV9BrJ7FgoIhYTtYvp+9w8Fw9LNBFYXrTv2/f7+ov+kEOuTSP3eWKm6v9Hu7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(6506007)(31686004)(8936002)(44832011)(53546011)(2906002)(6666004)(7416002)(5660300002)(41300700001)(6486002)(2616005)(36756003)(6512007)(966005)(86362001)(478600001)(31696002)(66556008)(38100700002)(66946007)(66476007)(66574015)(4326008)(8676002)(186003)(110136005)(83380400001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym1tVUVyNE5aWHZwN204bW1RNEJwNmdnTlAwOEE4WEV6NXZPa0xSUXNSSlRR?=
 =?utf-8?B?ZGVKTnA2Y0IwMmU0ZTlrQTNUN0QveXRzWmR0MVdxNDZhSGdvUnQvS1FMS2hE?=
 =?utf-8?B?UHZzbGxSV3QxZVVVdDcrOHZVOWtQNG9YRzBNNkwwSGNrM0huUyt4NzFxUmtR?=
 =?utf-8?B?ekhxSGF3RmRsMTVMbkhmcHlBbGtTUDhQVmZhOWR4bE9Db3FMZk1JblpDa3BY?=
 =?utf-8?B?S0JPWFV5bkpGZG5HcmI3OWRWVDBSR2NGV2JiajczN0tLeGVENTRNbk83Y29R?=
 =?utf-8?B?UUNZR0pPbUVaSzV1Ry92dzdhU0FOVU9USmlkL0ZLL2wvMWdNU1pEbGFhV1lu?=
 =?utf-8?B?QkduNDVtL29uQlQrcS9LMGVYTWR0TjNNWGVCaHRzbVoxcUhwaUR6WWgzN0pw?=
 =?utf-8?B?c3J5YlIvcEovblI5bFlPTzZNZS9GcnRZeDVHajZvd1BWVzBRMXZsL3JlSWR1?=
 =?utf-8?B?bFhOVTNwWEowc2pkTkhkT1JBeXE1QjhUWG02UGpyU0tLbVlFQWhlYmJMWXNB?=
 =?utf-8?B?MVhCUFBpcWY3YWVpOXAwTFIxN0o4U0dtQ0tJaFFMVEg0bll5R1pudFdyQjZi?=
 =?utf-8?B?SFc4UWpLdnljRzU5VHdlK2dwQ05CSFk0ZWdKMGVmWkhKM0V4bHpLOVFBcmJh?=
 =?utf-8?B?MkljMTlndUovWXZkM1lZUSt4NkdKdkZFRnRPTEc3RkxKYXNjSTZQVVdXUXRB?=
 =?utf-8?B?RjR6OUVrZTZFY2k1WlpJYjF1KzZsVG1NdmJhTVRqakthZytiWmkzWGhzaFdB?=
 =?utf-8?B?Qmo0dmtlUkxYREQ2aFAvU3ZTQllLbmNhRzZVSlBGNlhXam9ROXBodTJud2Q1?=
 =?utf-8?B?QjRMQ2laTUJyQ1N3WUtXeHBDUVE0V3F6RmtXMjhFeFRmRXVFTWV6M2JyTC9Z?=
 =?utf-8?B?dlVmeDhvN3l4TGROL0RGTnBkUmlweEF1aWlQU2RwMWRydVBWT01TRnBHRS9G?=
 =?utf-8?B?WkEyV3dxVldaVG90djJhL1crWXNpYmY2ck1lbk9QQjdzMXoyem1SbjY3MjFk?=
 =?utf-8?B?MndMVXdzTTN2L1ducXpqTlNXeUZTb2hSSEY0dTQ3dEFkb2lyQjZrOTUra01x?=
 =?utf-8?B?SU1SblZwb2FFMXNyWjdIVWJOb28yb0MyUE1sUEt0czZJS3IxV0RCSFNyTEZN?=
 =?utf-8?B?ODB5OGNEaURGSDdlWGhSc1NHNEZTcEFHY1V6RFk0emhtS2x6WjNvNjcwcjgz?=
 =?utf-8?B?cnQ2aVF1eUcyaVBGNFpNdXZwRnppL3dJQ1ZlcjkzNkdSZlZVbGU1STV4V2pF?=
 =?utf-8?B?c3J0bHVEeTZ0WTB6eFpuV0VoV0szQ3dFQTdWMkF5R1pHSHRGMW1hSGFTT2R2?=
 =?utf-8?B?enRlWkR2N2NtWjlZMEdPVlZ6WTg2VWI1Q1RhNnZmT2lxVmpwUG55TUkwMnZm?=
 =?utf-8?B?clRDMDM2Nzd1bUNLOEFKakVFWWl3bXNVMVphZWJJL3ovUEhKVDBneFM0cnlo?=
 =?utf-8?B?ejdsZWh0VWZtREhKUExhWUJYUm1PZFh0RzV3L3NEeUtnaStPK1o2YXZHY1ZM?=
 =?utf-8?B?Z29WSlhOd3F4dTRHdmNVVzZMQStjcTduOXpCZWtHT2NmRXpXQXdBZXVzekdj?=
 =?utf-8?B?S0lpbGc2NE5JaVo5bThGbEs4cE9ZczJFaml4eGlVSlNhUTdxUDhEdk8xSGwy?=
 =?utf-8?B?MU81UjNFVHdqODk3c3ZDK1lhM0gzaWtlMWphbU53VnVYVklCVGNvVUppVW03?=
 =?utf-8?B?d2F2QjN6b1lBSU9UaTRrNGZZREcrU0lCRUQ3YkFzKzNtcUllZ3RJQ2VnZWJE?=
 =?utf-8?B?NmRORkJoQkVxSFVGSW9Ud0tLZ0VQVytoZFZiUUhiU2RMTFdtclgwdXhpRExE?=
 =?utf-8?B?RGRwRnN1bEFEeWd0N0k1dzZWUjYyS05qbXB1TWk0dnVvRGkxRzJNQUNNS1lR?=
 =?utf-8?B?am5VSkVWaVgyQVovVDR0eGZDRHNyd2VlMmdrSlM2S3kydEFDTXBNYzUvdE41?=
 =?utf-8?B?UVg3eS9XRElWZnlDcmhIZEU0MXpjQXV6U1M1WlBEN2lXdmcyM0c1c05pUnJS?=
 =?utf-8?B?ME9JNHRKcyszNVF2NzVTUE0rcGlGeDIxc2lMd3djbmlmTjZPaGVyd1N5NjFw?=
 =?utf-8?B?TGxiMTk2YlhaU1VJZlljY1NQQ1FTbUIvSXJtbWM2M0ZYdnNFU0pqdENYR0p1?=
 =?utf-8?B?OUxGbFM3TC9pN1A2b0YrVzJtTDFBUlVHMTZKTlA1NWtiR1I0ck05SnNCa0Jp?=
 =?utf-8?Q?AmnBX8IkEmkhNHx0U3dIC2Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81884d96-fe89-439c-ed0f-08dabc2266ef
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 16:01:57.1081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dbPeYnm2wdj//HBQZvVW4ek5Ocv4+ijOZRPCTCTdnHShN/PKmTDZMP2j+gZhv2qfL/IBQj313aVkK5Js7Jbdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_07,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010120
X-Proofpoint-GUID: VdzsUK9XS8mTpaEhwXuhLzq1geQNuU61
X-Proofpoint-ORIG-GUID: VdzsUK9XS8mTpaEhwXuhLzq1geQNuU61
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 28/10/2022 22:35, Andrii Nakryiko wrote:
> On Fri, Oct 28, 2022 at 11:57 AM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 10/28/22 10:13 AM, Andrii Nakryiko wrote:
>>> On Thu, Oct 27, 2022 at 6:33 PM Yonghong Song <yhs@meta.com> wrote:
>>>>
>>>>
>>>>
>>>> On 10/27/22 4:14 PM, Andrii Nakryiko wrote:
>>>>> On Tue, Oct 25, 2022 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>>>
>>>>>> Hi BPF community,
>>>>>>
>>>>>> AFAIK there is a long standing feature request to use kernel headers
>>>>>> alongside `vmlinux.h` generated by `bpftool`. For example significant
>>>>>> effort was put to add an attribute `bpf_dominating_decl` (see [1]) to
>>>>>> clang, unfortunately this effort was stuck due to concerns regarding C
>>>>>> language semantics.
>>>>>>
>>>>>
>>>>> Maybe we should make another attempt to implement bpf_dominating_decl?
>>>>> That seems like a more elegant solution than any other implemented or
>>>>> discussed alternative. Yonghong, WDYT?
>>>>
>>>> I would say it would be very difficult for upstream to agree with
>>>> bpf_dominating_decl. We already have lots of discussions and we
>>>> likely won't be able to satisfy Aaron who wants us to emit
>>>> adequate diagnostics which will involve lots of other work
>>>> and he also thinks this is too far away from C standard and he
>>>> wants us to implement in a llvm/clang tool which is not what
>>>> we want.
>>>
>>> Ok, could we change the problem to detecting if some type is defined.
>>> Would it be possible to have something like
>>>
>>> #if !__is_type_defined(struct abc)
>>> struct abc {
>>> };
>>> #endif
>>>
>>> I think we talked about this and there were problems with this
>>> approach, but I don't remember details and how insurmountable the
>>> problem is. Having a way to check whether some type is defined would
>>> be very useful even outside of -target bpf parlance, though, so maybe
>>> it's the problem worth attacking?
>>
>> Yes, we discussed this before. This will need to add additional work
>> in preprocessor. I just made a discussion topic in llvm discourse
>>
>> https://discourse.llvm.org/t/add-a-type-checking-macro-is-type-defined-type/66268
>>
>> Let us see whether we can get some upstream agreement or not.
>>
> 
> Thanks for starting the conversation! I'll be following along.
>


I think this sort of approach assumes that vmlinux.h is included after
any uapi headers, and would guard type definitions with 

#if type_is_defined(foo)
struct foo {

};
#endif

...is that right? My concern is that the vmlinux.h definitions have
the CO-RE attributes. From a BPF perspective, would we like the vmlinux.h
definitions to dominate over UAPI definitions do you think, or does it
matter?

I was wondering if there might be yet another way to crack this;
if we did want the vmlinux.h type definitions to be authoritative
because they have the preserve access index attribute, and because
bpftool knows all vmlinux types, it could use that info to selectively
redefine those type names such that we avoid name clashes when later
including UAPI headers. Something like

#ifdef __VMLINUX_H__
//usual vmlinux.h type definitions
#endif /* __VMLINUX_H__ */

#ifdef __VMLINUX_ALIAS__
if !defined(timespec64)
#define timespec64 __VMLINUX_ALIAS__timespec64
#endif
// rest of the types define aliases here
#undef __VMLINUX_ALIAS__
#else /* unalias */
#if defined(timespec64)
#undef timespec64
#endif
// rest of types undef aliases here
#endif /* __VMLINUX_ALIAS__ */


Then the consumer does this:

#define __VMLINUX_ALIAS__
#include "vmlinux.h"
// include uapi headers
#include "vmlinux.h"

(the latter include of vmlinux.h is needed to undef all the type aliases)

I tried hacking up bpftool to support this aliasing scheme and while 
it is kind of hacky it does seem to work, aside from some issues with 
IPPROTO_* definitions - for the enumerated IPPROTO_ values linux/in.h does
this:

enum {
  IPPROTO_IP = 0,               /* Dummy protocol for TCP               */
#define IPPROTO_IP              IPPROTO_IP
  IPPROTO_ICMP = 1,             /* Internet Control Message Protocol    */
#define IPPROTO_ICMP            IPPROTO_ICMP


...so our enum value definitions for IPPROTO_ values clash with the above 
definitions. These could be individually ifdef-guarded if needed though I think.

I can send the proof-of-concept patch if it would help, I just wanted to 
check in case that might be a workable path too, since it just requires 
changes to bpftool (and changes to in.h).

Thanks!

Alan

 
>>>
>>>>
>>>>>
>>>>> BTW, I suggest splitting libbpf btf_dedup and btf_dump changes into a
>>>>> separate series and sending them as non-RFC sooner. Those improvements
>>>>> are independent of all the header guards stuff, let's get them landed
>>>>> sooner.
>>>>>
>>>>>> After some discussion with Alexei and Yonghong I'd like to request
>>>>>> your comments regarding a somewhat brittle and partial solution to
>>>>>> this issue that relies on adding `#ifndef FOO_H ... #endif` guards in
>>>>>> the generated `vmlinux.h`.
>>>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>> Eduard Zingerman (12):
>>>>>>     libbpf: Deduplicate unambigous standalone forward declarations
>>>>>>     selftests/bpf: Tests for standalone forward BTF declarations
>>>>>>       deduplication
>>>>>>     libbpf: Support for BTF_DECL_TAG dump in C format
>>>>>>     selftests/bpf: Tests for BTF_DECL_TAG dump in C format
>>>>>>     libbpf: Header guards for selected data structures in vmlinux.h
>>>>>>     selftests/bpf: Tests for header guards printing in BTF dump
>>>>>>     bpftool: Enable header guards generation
>>>>>>     kbuild: Script to infer header guard values for uapi headers
>>>>>>     kbuild: Header guards for types from include/uapi/*.h in kernel BTF
>>>>>>     selftests/bpf: Script to verify uapi headers usage with vmlinux.h
>>>>>>     selftests/bpf: Known good uapi headers for test_uapi_headers.py
>>>>>>     selftests/bpf: script for infer_header_guards.pl testing
>>>>>>
>>>>>>    scripts/infer_header_guards.pl                | 191 +++++
>>>>>>    scripts/link-vmlinux.sh                       |  13 +-
>>>>>>    tools/bpf/bpftool/btf.c                       |   4 +-
>>>>>>    tools/lib/bpf/btf.c                           | 178 ++++-
>>>>>>    tools/lib/bpf/btf.h                           |   7 +-
>>>>>>    tools/lib/bpf/btf_dump.c                      | 232 +++++-
>>>>>>    .../selftests/bpf/good_uapi_headers.txt       | 677 ++++++++++++++++++
>>>>>>    tools/testing/selftests/bpf/prog_tests/btf.c  | 152 ++++
>>>>>>    .../selftests/bpf/prog_tests/btf_dump.c       |  11 +-
>>>>>>    .../bpf/progs/btf_dump_test_case_decl_tag.c   |  39 +
>>>>>>    .../progs/btf_dump_test_case_header_guards.c  |  94 +++
>>>>>>    .../bpf/test_uapi_header_guards_infer.sh      |  33 +
>>>>>>    .../selftests/bpf/test_uapi_headers.py        | 197 +++++
>>>>>>    13 files changed, 1816 insertions(+), 12 deletions(-)
>>>>>>    create mode 100755 scripts/infer_header_guards.pl
>>>>>>    create mode 100644 tools/testing/selftests/bpf/good_uapi_headers.txt
>>>>>>    create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
>>>>>>    create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_header_guards.c
>>>>>>    create mode 100755 tools/testing/selftests/bpf/test_uapi_header_guards_infer.sh
>>>>>>    create mode 100755 tools/testing/selftests/bpf/test_uapi_headers.py
>>>>>>
>>>>>> --
>>>>>> 2.34.1
>>>>>>
