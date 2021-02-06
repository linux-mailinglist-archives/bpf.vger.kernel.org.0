Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E08311C22
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 09:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhBFI1y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 03:27:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhBFI1x (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 6 Feb 2021 03:27:53 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1168OV2i027157;
        Sat, 6 Feb 2021 00:26:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bTlvICdvTstBa/b/QCToPiTwr20i+Ermovj+tnxo54I=;
 b=ZVVTdt3T0313ea2h9BproYuiSpxC9V6+pLATeQyvAs0gUQawUBmbSQdEuHo62gZMiJST
 NY/O3AfXmzTTFGdy2Hb8SOGky7t/sgEknNwhlCaqEMgxcviHKE5JkXLxCNdUuP788tBx
 cj0inblfUSraRaFOZs6hH5/KMrRFVKvQ/Qs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36hmat0gpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Feb 2021 00:26:52 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 6 Feb 2021 00:26:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8jRvNHgE/P0DKACESCd0QtUIUb4jqM8vBKcfGZv/3qhB4YXR+nnxuC2hcXP78yUHlC6atViaKcuhRWB4rPq2H0k67s1T5QMXIaoppzcSASoEOhjRyWu+D8/bNtG8EMPU65f+QKdkbqxEzhosjALsJEvjD1Mq8oXeJpw6ab2Phg3flpxPRBZa9sIMdbvoDDKhIhrn8kxlkQ1CiZTTP7wR0+jJkluXzf7hgU5VdjD4dg6rjsJptX6ZHMAPQ/TMkvJhPVIUo7mbXVLh742TuQc12AKuj5uCZAORsxPOq65qcZfuU816dvOtyCUn/o7XXL3KhwKINj+MirQ/Zqz6crDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdnzMZRgMewYckoP45SuoVjJjLuUOfrpDunUi0r6k3s=;
 b=LBS8OrLFqutTyn/sZIgWXJ/7lPjiuXvs7urvQxs+BDDjIdQERTQjCp0ZdliktvNu1bWv53XmfuHdSY++O0fVMW3kDVEGlIWHnMclxhHhrLpbIvElJrX623eVLb4LxjIN9ELLX8ulbyFPOtx7eW00cmC6ZQBqeS57TXa8U1NgFHRM0x88CPrA7fdNHw09zK/ztCZ5mZurR2hQGs1fKCt0Tczm9G0Uc0+vVgJ3EpRUFhKhcsHyfIs737iWzATpOmG8bmbmpr32mITkU7O2xKxrAWcYXIToeE9FnnDPiP2xQ/y15RxXyjzH9tWNSEmEhrpVIIrDSffHGFn0SfUwnKWd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdnzMZRgMewYckoP45SuoVjJjLuUOfrpDunUi0r6k3s=;
 b=EcYlGyklZlckUYOA974aPfD4tkiE7j6QDIG3ef0AMoNK39/FH7xc5PDwgCQ1sqxOAx/KCGEt1UZb8Ewo3XewjQQYmKNGit7mEo2Z8WXy3T70kIipL7jhlzPfSGBoTK3abOW4KTQNcQOs/a6PtcH+V9PF3iUHkELIOHc+lbaNao0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2262.namprd15.prod.outlook.com (2603:10b6:a02:8c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Sat, 6 Feb
 2021 08:26:48 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.028; Sat, 6 Feb 2021
 08:26:48 +0000
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     <sedat.dilek@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
References: <20210204220741.GA920417@kernel.org>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org>
 <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
 <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com>
 <20210205192446.GH920417@kernel.org>
 <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com>
 <CA+icZUUcjJASPN8NVgWNp+2h=WO-PT4Su3-yHZpynNHCrHEb-w@mail.gmail.com>
 <d59c2a53-976c-c304-f208-67110bdd728a@fb.com>
 <CA+icZUVhgnJ9j7dnXxLQi3DcmLrqpZgcAo2wmHJ_OxSQyS6DQg@mail.gmail.com>
 <CA+icZUWFx47jWJsV6tyoS5f18joPLyE8TOeeyVgsk65k9sP2WQ@mail.gmail.com>
 <CA+icZUUj1P_PAj=E8iF=C4m6gYm9zqb+WWbOdoTqemTeGnZbww@mail.gmail.com>
 <CA+icZUWY0zkOb36gxMOuT5-m=vC5_e815gkSEyM45sO+jgcCZg@mail.gmail.com>
 <CA+icZUW+4=WUexA3-qwXSdEY2L4DOhF1pQfw9=Bf2invYF1J2Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8ff11fa8-46cd-5f20-b988-20e65e122507@fb.com>
Date:   Sat, 6 Feb 2021 00:26:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CA+icZUW+4=WUexA3-qwXSdEY2L4DOhF1pQfw9=Bf2invYF1J2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:622]
X-ClientProxiedBy: MWHPR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:300:95::14) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::11b4] (2620:10d:c090:400::5:622) by MWHPR13CA0028.namprd13.prod.outlook.com (2603:10b6:300:95::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Sat, 6 Feb 2021 08:26:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6e5e6ec-05c8-42c8-f950-08d8ca78f23c
X-MS-TrafficTypeDiagnostic: BYAPR15MB2262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2262872B9FB693949B3D6A07D3B19@BYAPR15MB2262.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnrgZpYrD4XfkdGwXSTTSViWJZhYiUIcPU0lx0rVhJq9qGylsfhxmNdkZxjRhjN9wA6x5MIVjJ/0ocXbhBANIkNpERIczW8O6O6Z8wossZlZ2OH6DVdeYED0eK9PE7DJVqFMxgEJsIB4B2/dOB1cqbDUcuO0gpJgzdBlD+k2OzXsEvORfOTrbNvomXwI4oQNGPqYW60Bj0tMbaFa65tdZrUeR6L0VL9WQi68Ipiug0nMq4BeWpEWgwtdVxG+qaeMFjyBQqoicdG9oZ6FlwjgzI80OAnpZUOEhnUYihymfnH7nLN465m+4a4vmevkdSSt1ubzGeTfEE98aE+dMIHisy8h8nzydx5/JMrh7FSRg0tl14XzrFEj5BuvYKCtO9efdsctzYV1SNn8LU8CMUE5iQ4hxks+nqt7CL9Mwix9eCv3sGjfNO6QVOVnn73Uu76LKTMvUexnDVOw3BKriX1fWryij/20ViMNk4i1yW9F33/+lxeLsRnKnnCIpiOFPu+BtN3VdxXIeT4NGgrS+LacoUCRCGXOhceKisWXn8Z48C/FiMgQv2xqy/I01yHkW+OfQeR7Bzl+sJ+BpYtKL+Huho1L4ryq142YUGblRbx2tmsE4CAwhVXPBoAat3mTpWyLIo20hEzENKFD8Qc6TRHiE+zaGsc+ejRvDP+x1z6t7rezNcg4yELSEIsPDtoaiAf8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(366004)(39860400002)(36756003)(8936002)(2616005)(5660300002)(966005)(2906002)(30864003)(54906003)(6916009)(4326008)(478600001)(31696002)(7416002)(316002)(52116002)(31686004)(6486002)(186003)(16526019)(66476007)(83380400001)(53546011)(86362001)(66574015)(66556008)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YjRJQXhkK3dtaXNEZFRSZ2xJcDRXRVN5K0NaczMxTnZKZEpwK012eVVTTjc2?=
 =?utf-8?B?dHo1R0EvNDB5YkVTa1c0L3M1U2xRcTk1Z1VIakRXQ2YvTDB2YjVYMFJjSzFC?=
 =?utf-8?B?ZHRqaGxZVE9vMFJCVGg0R2RTa3BRNGtXZ2VScFNKRlRxUlo0WUhHRVAxa2Rv?=
 =?utf-8?B?NU4xUDhHUUNYUXZFaEp3OGk3MHZjb0RoZGlvYlZOR2pWcDhtRkQ2c2Q0cEIx?=
 =?utf-8?B?OVpEcmJsOXZrNUJscTFIMVBlWks2R3FLcENVYjNWNFkwYjh6RktDUXNrd0RB?=
 =?utf-8?B?cno4QVVVR2tVb1ZIWnBhL2xiOWl6allhNHExRWNIM1VHVXBHTnN4M09yQm9W?=
 =?utf-8?B?d0ZLejNEcUlhUTVwb0NpZzBkMHRFZ1FWaWhZQkVnREhZaFZhc0x6S3RoU0dC?=
 =?utf-8?B?ZUxuZ2lDblhMSEU1VFMyMFFsazJPWmkwc1J6Q1MwTmV6MlAvTWd4U1hsb0o4?=
 =?utf-8?B?Vm8rRHovcURCeUk4RGxqNm0reVlSN3N4b2huTFUwMG1BSndEdVNLWW1KcWpo?=
 =?utf-8?B?K25wUU1LT2hENU50OU5LYXVTUVRRczVUbnBBTmh6UmxVTDR3dzlETXlXMEsr?=
 =?utf-8?B?NklSS1hQbzk1SEpuS1psMjQ3OVhCZjNnbldaRE9kN3pHcjFqam1pK3ZGbXFx?=
 =?utf-8?B?Qm5GZk95QUF5Q0p6MWVlVnVlM09lNlpJZmw5VVhwUmtiR1ZuS20wQTZoSE8r?=
 =?utf-8?B?cDMvUUFIeXpQR2p1UFR6RE90cXYwZk5Vb3lUdktpMFdHS1lOQ2VRMEhpL01O?=
 =?utf-8?B?R2RRVUwvTkx3QnE1eGsrSkh3OGh4ZFZMVGdLaHVvelZMd2kwNFhEQkl6U2pt?=
 =?utf-8?B?eWxwTURJR0tuRG5naDJrVmxOMWVBdWxkSTJNeDV2WEVTWXNvR3c1ZEJlYmZa?=
 =?utf-8?B?Smtnc1NZbVpRbzdDTnBWcjgrWGI1RkN0R1RKYlA1MHlNcVR2OE1IUHdFUEFk?=
 =?utf-8?B?aFo4ZlRPcTBUckN6RDJHa1hrS2tBZ05LN0JFU2NCVjFzSmNuUjlhbWYrYkFF?=
 =?utf-8?B?cGx1MW5TY2tyZU1qS3FnQkVMb2VJdm9qdk9yeElQYkVEQXkzZk4yVWZwYXRm?=
 =?utf-8?B?ck52NmJFNy93WEFBdFZWVWc3c0xGZURZNW1sRW1NVkNBMmsxT3A0VDRCMnBr?=
 =?utf-8?B?amFXWnhxRzg4NVZMbysrZ1NKbmJ5MUhJTytIMzcxejYyZXdZTE1VVU1vRnR6?=
 =?utf-8?B?d05TclhVV2Q5MzgyNjJyM2MzM0lYVDRDUHRTYlk5UGpYLzVoZFJDME94dU1U?=
 =?utf-8?B?OFpzWGUvMVl2ZitkKzM3WUxVS3VRbUpsbEtYaGoxdW15akZmcHZzT3dlR0hY?=
 =?utf-8?B?YTk1OGFjTGlJdDZFaEU2c3pJZnRMVFZndVNlOEd0RjRaSDZkNDlXWU0yOENB?=
 =?utf-8?B?WWJGKy9JbzFGUGNDS3FtUGxHMHZZZHdsR0lxQVdMYXVWZzVjWUV0TEVBSlQr?=
 =?utf-8?B?czZCeVIxdmFnb1ZyaWp5RGMxbVNBUFhWeTRPdU5uVUZSekl3MkhRYlR6VUFP?=
 =?utf-8?B?TmZNTVR2WTNZU296d3lNUTd1Q2JtWEMyYVZZRzcwNTRWTlN0SXU4NEpxNW9C?=
 =?utf-8?B?c1VEOXVNNEVDeUZLZUpQRjY4YkEwOUxTVTZ4Y0tPQ29pelc0N3lFbC9QUHRH?=
 =?utf-8?B?QXNORjBueW9tLy8vcnFGOW1FampVd2NKeEY3QzM1RkpJeEVxd0ZEMHdsdVVN?=
 =?utf-8?B?UHN4MlRIYmtZaEx3UHJTOVRLRmVhL2thSmphalcxQXA2NVkxdEpIOHhxRjJ4?=
 =?utf-8?B?TWZyS2dMVzZBN1BYdWxhOHpkcTV6QXMrNkxZVlZmUXl4MSsvWUlZeDdjR3lK?=
 =?utf-8?Q?/dBMwzEgbF/zrlUCwE8PotGmqNAq4PLg0wuFI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e5e6ec-05c8-42c8-f950-08d8ca78f23c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2021 08:26:48.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qT2yhrX2kqgUB+AyNobgg/2r+UrjnURcH4Nqx/1ea8voXQhksJS6cWW1nTiO8fN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2262
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-06_02:2021-02-05,2021-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102060057
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/5/21 10:52 PM, Sedat Dilek wrote:
> On Sat, Feb 6, 2021 at 7:26 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>
>> On Sat, Feb 6, 2021 at 6:53 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>
>>> On Sat, Feb 6, 2021 at 6:44 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>
>>>> On Sat, Feb 6, 2021 at 4:34 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>>
>>>>> On Fri, Feb 5, 2021 at 10:54 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2/5/21 12:31 PM, Sedat Dilek wrote:
>>>>>>> On Fri, Feb 5, 2021 at 9:03 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/5/21 11:24 AM, Arnaldo Carvalho de Melo wrote:
>>>>>>>>> Em Fri, Feb 05, 2021 at 11:10:08AM -0800, Yonghong Song escreveu:
>>>>>>>>>> On 2/5/21 11:06 AM, Sedat Dilek wrote:
>>>>>>>>>>> On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>>>>>>>> Grepping through linux.git/tools I guess some BTF tools/libs need to
>>>>>>>>>>> know what BTF_INT_UNSIGNED is?
>>>>>>>>>
>>>>>>>>>> BTF_INT_UNSIGNED needs kernel support. Maybe to teach pahole to
>>>>>>>>>> ignore this for now until kernel infrastructure is ready.
>>>>>>>>>
>>>>>>>>> Yeah, I thought about doing that.
>>>>>>>>>
>>>>>>>>>> Not sure whether this information will be useful or not
>>>>>>>>>> for BTF. This needs to be discussed separately.
>>>>>>>>>
>>>>>>>>> Maybe search for the rationale for its introduction in DWARF.
>>>>>>>>
>>>>>>>> In LLVM, we have:
>>>>>>>>      uint8_t BTFEncoding;
>>>>>>>>      switch (Encoding) {
>>>>>>>>      case dwarf::DW_ATE_boolean:
>>>>>>>>        BTFEncoding = BTF::INT_BOOL;
>>>>>>>>        break;
>>>>>>>>      case dwarf::DW_ATE_signed:
>>>>>>>>      case dwarf::DW_ATE_signed_char:
>>>>>>>>        BTFEncoding = BTF::INT_SIGNED;
>>>>>>>>        break;
>>>>>>>>      case dwarf::DW_ATE_unsigned:
>>>>>>>>      case dwarf::DW_ATE_unsigned_char:
>>>>>>>>        BTFEncoding = 0;
>>>>>>>>        break;
>>>>>>>>
>>>>>>>> I think DW_ATE_unsigned can be ignored in pahole since
>>>>>>>> the default encoding = 0. A simple comment is enough.
>>>>>>>>
>>>>>>>
>>>>>>> Yonghong Son, do you have a patch/diff for me?
>>>>>>
>>>>>> Looking at error message from log:
>>>>>>
>>>>>>    LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
>>>>>> .tmp_vmlinux.btf
>>>>>> [115] INT DW_ATE_unsigned_1 Error emitting BTF type
>>>>>> Encountered error while encoding BTF.
>>>>>>
>>>>>> Not exactly what is the root cause. Maybe bt->bit_size is not
>>>>>> encoded correctly. Could you put vmlinux (in the above it is
>>>>>> .tmp_vmlinux.btf) somewhere, I or somebody else can investigate
>>>>>> and provide a proper fix.
>>>>>>
>>>>>
>>>>> [ TO: Masahiro ]
>>>>>
>>>>> Thanks for taking care Yonghong - hope this is your first name, if not
>>>>> I am sorry.
>>>>> In case of mixing my first and last name you will make me female -
>>>>> Dilek is a Turkish female first name :-).
>>>>> So, in some cultures you need to be careful.
>>>>>
>>>>> Anyway... back to business and facts.
>>>>>
>>>>> Out of frustration I killed my last build via `make distclean`.
>>>>> The whole day I tested diverse combination of GCC-10 and LLVM-12
>>>>> together with BTF Kconfigs, selfmade pahole, etc.
>>>>>
>>>>> I will do ne run with some little changes:
>>>>>
>>>>> #1: Pass LLVM_IAS=1 to make (means use Clang's Integrated ASsembler -
>>>>> as per Nick this leads to the same error - should be unrelated)
>>>>> #2: I did: DEBUG_INFO_COMPRESSED y -> n
>>>>>
>>>>> #2 I did in case you need vmlinux and I have to upload - I will
>>>>> compress the resulting vmlinux with ZSTD.
>>>>> You need vmlinux or .tmp_vmlinux.btf file?
>>>>> Nick was not allowed from his company to download from a Dropbox link.
>>>>> So, as an alternative I can offer GoogleDrive...
>>>>> ...or bomb into your INBOX :-).
>>>>>
>>>>> Now, why I CCed Masahiro:
>>>>>
>>>>> In case of ERRORs when running `scripts/link-vmlinux.sh` above files
>>>>> will be removed.
>>>>>
>>>>> Last, I found a hack to bypass this - means to keep these files (I
>>>>> need to check old emails).
>>>>>
>>>>> Masahiro, you see a possibility to have a way to keep these files in
>>>>> case of ERRORs without doing hackery?
>>>>>
>>>>>  From a previous post in this thread:
>>>>>
>>>>> + info BTF .btf.vmlinux.bin.o
>>>>> + [  != silent_ ]
>>>>> + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
>>>>>   BTF     .btf.vmlinux.bin.o
>>>>> + LLVM_OBJCOPY=llvm-objcopy /opt/pahole/bin/pahole -J .tmp_vmlinux.btf
>>>>> [2] INT long unsigned int Error emitting BTF type
>>>>> Encountered error while encoding BTF.
>>>>> + llvm-objcopy --only-section=.BTF --set-section-flags
>>>>> .BTF=alloc,readonly --strip-all .tmp_vmlinux.btf .btf.vmlinux.bin.o
>>>>> ...
>>>>> + info BTFIDS vmlinux
>>>>> + [  != silent_ ]
>>>>> + printf   %-7s %s\n BTFIDS vmlinux
>>>>>   BTFIDS  vmlinux
>>>>> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
>>>>> FAILED: load BTF from vmlinux: Invalid argument
>>>>> + on_exit
>>>>> + [ 255 -ne 0 ]
>>>>> + cleanup
>>>>> + rm -f .btf.vmlinux.bin.o
>>>>> + rm -f .tmp_System.map
>>>>> + rm -f .tmp_vmlinux.btf .tmp_vmlinux.kallsyms1
>>>>> .tmp_vmlinux.kallsyms1.S .tmp_vmlinux.kallsyms1.o
>>>>> .tmp_vmlinux.kallsyms2 .tmp_vmlinux.kallsyms2.S .tmp_vmlinux.kallsyms
>>>>> 2.o
>>>>> + rm -f System.map
>>>>> + rm -f vmlinux
>>>>> + rm -f vmlinux.o
>>>>> make[3]: *** [Makefile:1166: vmlinux] Error 255
>>>>>
>>>>> ^^^ Look here.
>>>>>
>>>>
>>>> With this diff:
>>>>
>>>> $ git diff scripts/link-vmlinux.sh
>>>> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>>>> index eef40fa9485d..40f1b6aae553 100755
>>>> --- a/scripts/link-vmlinux.sh
>>>> +++ b/scripts/link-vmlinux.sh
>>>> @@ -330,7 +330,7 @@ vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
>>>> # fill in BTF IDs
>>>> if [ -n "${CONFIG_DEBUG_INFO_BTF}" -a -n "${CONFIG_BPF}" ]; then
>>>>         info BTFIDS vmlinux
>>>> -       ${RESOLVE_BTFIDS} vmlinux
>>>> +       ##${RESOLVE_BTFIDS} vmlinux
>>>> fi
>>>>
>>>> if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
>>>>
>>>> This files are kept - not removed:
>>>>
>>>> $ LC_ALL=C ll .*btf* vmlinux vmlinux.o
>>>> -rwxr-xr-x 1 dileks dileks  31M Feb  6 06:37 .btf.vmlinux.bin.o
>>>> -rwxr-xr-x 1 dileks dileks 348M Feb  6 06:37 .tmp_vmlinux.btf
>>>> -rwxr-xr-x 1 dileks dileks 348M Feb  6 06:37 vmlinux
>>>> -rw-r--r-- 1 dileks dileks 344M Feb  6 06:37 vmlinux.o
>>>>
>>>> Pleas let me know where to upload - Dropbox or GoogleDrive or
>>>> elsewhere and give me a link.
>>>>
>>>
>>>
>>> WOW, ZSTD is great :-).
>>>
>>> $ zstd -19 -T0 -v vmlinux
>>> *** zstd command line interface 64-bits v1.4.8, by Yann Collet ***
>>> Note: 2 physical core(s) detected
>>> vmlinux              : 22.71%   (364466016 => 82784801 bytes, vmlinux.zst)
>>>
>>> $ du -m vmlinux*
>>> 348     vmlinux
>>> 79      vmlinux.zst
>>>
>>
>> Dropbox link:
>> https://www.dropbox.com/sh/kvyh8ps7na0r1h5/AABfyNfDZ2bESse_bo4h05fFa?dl=0
>>
>> I hope this is public available.
>>
> 
> Inspecting vmlinux with llvm-dwarf:
> 
> $ /opt/llvm-toolchain/bin/llvm-dwarfdump vmlinux | grep DW_AT_name |
> grep DW_ATE_ | sort | uniq
>                 DW_AT_name      ("DW_ATE_signed_1")
>                 DW_AT_name      ("DW_ATE_signed_16")
>                 DW_AT_name      ("DW_ATE_signed_32")
>                 DW_AT_name      ("DW_ATE_signed_64")
>                 DW_AT_name      ("DW_ATE_signed_8")
>                 DW_AT_name      ("DW_ATE_unsigned_1")
>                 DW_AT_name      ("DW_ATE_unsigned_128")
>                 DW_AT_name      ("DW_ATE_unsigned_16")
>                 DW_AT_name      ("DW_ATE_unsigned_24")
>                 DW_AT_name      ("DW_ATE_unsigned_32")
>                 DW_AT_name      ("DW_ATE_unsigned_40")
>                 DW_AT_name      ("DW_ATE_unsigned_64")
>                 DW_AT_name      ("DW_ATE_unsigned_8")
> 
> - Sedat -

Thanks for the above dropbot link, I am able to reproduce the issue.

I tried to use latest llvm + Nick's patch + latest pahole + dwarf5 
config option to compile kernel with LLVM=1 LLVM_IAS=1, somehow
I did not hit the issue. It complained like

   MODPOST vmlinux.symvers
WARNING: modpost: vmlinux.o(.text+0x6ce73): Section mismatch in 
reference from the function __nodes
_weight() to the variable .init.data:numa_nodes_parsed
The function __nodes_weight() references
the variable __initdata numa_nodes_parsed.
This is often because __nodes_weight lacks a __initdata
annotation or the annotation of numa_nodes_parsed is wrong.

but otherwise compilation is fine.

With the above vmlinux, the issue appears to be handling
DW_ATE_signed_1, DW_ATE_unsigned_{1,24,40}.

The following patch should fix the issue:

-bash-4.4$ git diff 

diff --git a/dwarf_loader.c b/dwarf_loader.c 

index b73d786..0341b5e 100644 

--- a/dwarf_loader.c 

+++ b/dwarf_loader.c 

@@ -467,8 +467,16 @@ static struct base_type *base_type__new(Dwarf_Die 
*die, struct cu *cu)
 

         if (bt != NULL) { 

                 tag__init(&bt->tag, cu, die); 

-               bt->name = strings__add(strings, attr_string(die, 
DW_AT_name));
-               bt->bit_size = attr_numeric(die, DW_AT_byte_size) * 8; 

+               const char *name = attr_string(die, DW_AT_name); 

+               bt->name = strings__add(strings, name); 

+               /* DW_ATE_unsigned_1 has DW_AT_byte_size == 0. 

+                * specially process it. 

+                */ 

+               if (strcmp(name, "DW_ATE_unsigned_1") == 0) 

+                       bt->bit_size = 1; 

+               else 

+                       bt->bit_size = attr_numeric(die, 
DW_AT_byte_size) * 8;
+ 

                 uint64_t encoding = attr_numeric(die, DW_AT_encoding);
                 bt->is_bool = encoding == DW_ATE_boolean;
                 bt->is_signed = encoding == DW_ATE_signed;
diff --git a/libbtf.c b/libbtf.c
index 9f76283..b5aa077 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -367,13 +367,32 @@ static void btf_log_func_param(const struct 
btf_elf *btfe,
         }
  }

+/* btf requires power-of-2 bytes, yet dwarf may have something like
+ * DW_ATE_unsigned_24 which encodes as 24 bits (3 bytes).
+ */
+static int bits_to_int_bytes(uint16_t bit_size)
+{
+       if (bit_size <= 8)
+               return 1;
+       if (bit_size <= 16)
+               return 2;
+       if (bit_size <= 32)
+               return 4;
+       if (bit_size <= 64) 

+               return 8; 

+       if (bit_size <= 128)
+               return 16;
+       /* BTF supports upto 16byte int (__int128). */
+       return -1;
+}
+
  int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct 
base_type *bt,
                                const char *name)
  {
         struct btf *btf = btfe->btf;
         const struct btf_type *t;
         uint8_t encoding = 0;
-       int32_t id;
+       int32_t id, nbytes;

         if (bt->is_signed) {
                 encoding = BTF_INT_SIGNED;
@@ -384,7 +403,13 @@ int32_t btf_elf__add_base_type(struct btf_elf 
*btfe, const struct base_type *b
t,
                 return -1;
         }
-       id = btf__add_int(btf, name, BITS_ROUNDUP_BYTES(bt->bit_size), 
encoding);
+       nbytes = bits_to_int_bytes(bt->bit_size);
+       if (nbytes < 0) {
+               fprintf(stderr, "not supported bit_size %hu\n", 
bt->bit_size);
+               return -1;
+       }
+
+       id = btf__add_int(btf, name, nbytes, encoding);
         if (id < 0) {
                 btf_elf__log_err(btfe, BTF_KIND_INT, name, true, "Error 
emitting BTF type");
         } else {
-bash-4.4$

Please help do a test. I can submit a formal patch tomorrow.
