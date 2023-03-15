Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99F76BB9C5
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 17:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCOQgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 12:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCOQgj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 12:36:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA53B6A062;
        Wed, 15 Mar 2023 09:36:23 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F6csus007578;
        Wed, 15 Mar 2023 09:36:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : mime-version; s=s2048-2021-q4;
 bh=oTLW3wvZC96guW6n+tvLYnnu4mw//I+opho4Tt0Dqvk=;
 b=mjecSHdh2Fw9Ys0FcR2wZZY2MYEPflQBb1oxccCV9ofo+VpxzKo5cWbZuK468mtrquuC
 6qfip9gz6OfPT/5ZLXDd3vW/G0Atxlj4zChed1kVRgfcFvryQR1djnDQIWvs7LfVWWwx
 TXGgb3sSsXsSB0QrI0/LU6Xv+kacCVqu8BoR9fly0lbBeFDCjBtiKqGd3L18Byi/5+ip
 s+CFQQm6LDgNikDvbRpCFn2tXHmlfxaWPW7cAbkocedwLKKrW9/sLXUfJhEUhUStuTY1
 HkNfUoWYyYbECNh8VzOsx9uTZx+dAZ1q8aS3kPKyfrnOSpcnhUNjV6k4MWNRplTFN82X 7g== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pb2c65c45-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 09:36:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNza0E9p7UEQaiWM2vYmGxhU/BwMXJ0ZIgXXMVpp0JUvrZH2nmtIoj60cy3WaoHuyB3aB4gjAIB2NSukqD5pFk7PzzDWengmXj1fMIAtc0K8RMnZWAL5C29Y/ueEZGrqE5Cf/zOvYVENIMlqg3Qwd2Sk22udGnZrA2MyIWSSHP3btoFDlKgu8/dpvIh6kImYf/XqilyU0c34AluZ+iowKMMO94C/ufjCBPaGqheQ+IS4BC5KIt1eFDdPQPmaBsUQ8IWtP7Dxu3d9v7qE6c8wPwGdhCzSMXeWRI17ybQHUtanH4CpOSLAK7xYMvuHRvOEiktytIUoQ6OJa+n51uvE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPzmA6faAuxSZraUm6qbiaopgx0PFf67pwSfJiIgtwA=;
 b=JZc40lQL2r+439ZxlmuQ+CqqX4mRBe8o17yHBJbrECTbCieotyNkIlUtQP0z9z+dPr5fz7Lg8u1NLoN462xA6zYfYluSlQ6tGlTx/xkFejYMtqAcdH6ebMdhPYQ4FQHfpdDlY/dud5OYMfdxEfvnXzQrXo9SLOCFh35NZRY/mOBLaSHAHu1Al7zm9TbMGoJPyyUG1oPwSFB5hXkgfw8jP0+BfTYnsCCLwHs4WtoeeGDbqpVgLz30fW7tuqMY08zB3OfF+aRibOkISU6ujQJdcu5eRvFP0EtKq4OQVYRtCv/Go/jPIfqFCTJTaJCKe7daTtt3oaKdhY//zg++6ESy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM4PR15MB5354.namprd15.prod.outlook.com (2603:10b6:8:5d::18) by
 DM6PR15MB3813.namprd15.prod.outlook.com (2603:10b6:5:2b0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.29; Wed, 15 Mar 2023 16:36:19 +0000
Received: from DM4PR15MB5354.namprd15.prod.outlook.com
 ([fe80::8c04:a4a9:241e:2ec1]) by DM4PR15MB5354.namprd15.prod.outlook.com
 ([fe80::8c04:a4a9:241e:2ec1%4]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 16:36:19 +0000
From:   Sreevani Sreejith <ssreevani@meta.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Sreevani Sreejith <ssreevani@meta.com>,
        "psreep@gmail.com" <psreep@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "mykola@meta.com" <mykola@meta.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH V3 bpf-next] BPF, docs: libbpf Overview Document
Thread-Topic: [PATCH V3 bpf-next] BPF, docs: libbpf Overview Document
Thread-Index: AQHZU3uIPS1/hSPDT0upU7tPQaXGO674efyAgAA2bYCAAoUrAIAAKHuAgACzdgA=
Date:   Wed, 15 Mar 2023 16:36:19 +0000
Message-ID: <C5E014CB-1A9D-4A29-93AC-1025CBCFC2BF@fb.com>
References: <20230310180928.2462527-1-ssreevani@meta.com>
 <ZA7wm8scokV+XPav@debian.me> <20230313125947.GB2392@maniforge>
 <ZBE7eMsAifEQgRQv@debian.me> <20230315055349.GA20638@maniforge>
In-Reply-To: <20230315055349.GA20638@maniforge>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR15MB5354:EE_|DM6PR15MB3813:EE_
x-ms-office365-filtering-correlation-id: e5408e1a-2e2a-4592-99bd-08db257367bf
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BKwX2WpioOFAO/YKj50wrhAUu8R49WYKBo5LcJtjrqeXYQ0tMAu/cruj9o+KkFvuOWhbwzAbU3x3R3LqXFJmparlN9qItj9KYk865VdbvyNwSEnRMrjKt1AfOx0FEpA3E5pOoy78HpYEPdgFU1JecUbF9Uku/hr3S6HyS+RwwfkHO2JbPr7FeXOBRKfVHvBfleNPq3Py5+5IdqPD61HGlqRsmBgJfnIEom9EaYqSGnEu6+9AQCUp5clT2PWVKJ4ty6XHmH7bWU3h3utGJaNbrDSi0sMVceptUst8M3Yv9Ew1+pHbmQS8guvhOZgdCLNdZFMueAefw69l5o/AfSJvg1ZPH86mgKUQApWEn2Vx5zdfkcBHdtSMDDPhuWgpnDDoRqxwRf4+3M3LuoFwGdfY4+RGDZZTeP1d3R5E3gO5aQu8xDJxcdhM5cIveX6RNDXWtCkumw04gTgbWcg8fdLpzc4XaRhkCsE8P25INRGIqprHK3K8WjV5n8UXq8WsMF81TpOzYRP/oA+y1Ir3qeOX//ep5rsC/KXheNz67G+UtimN7CWsGPQQqpRPpvL94OVmrCGM2Ny6IkRJqCnxi/N6G9011PWs0XxBUBbjRuutDs1FzhH8ZiOS46bgVU9qpRqBe/ICX/7wibJczA+jDLB6qNUk2lUDMEMoEVj7ObvjQ2Jmeuett/hk3JJU6lnSrho1TkgfYFzsO/UraJO0vKMfYJJ0e+gPFQeaW5mSE8xi4ho=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR15MB5354.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199018)(2906002)(122000001)(83380400001)(64756008)(36756003)(5660300002)(6916009)(66556008)(66476007)(66946007)(8936002)(33656002)(66446008)(4326008)(8676002)(76116006)(38070700005)(91956017)(38100700002)(316002)(86362001)(54906003)(478600001)(186003)(41300700001)(9686003)(53546011)(71200400001)(6486002)(966005)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tjTn/UK6htE8suGv5NHEdu0q981CfF5WfgXsOukb6M2FWVH3kuXlvjmfZ9l2?=
 =?us-ascii?Q?kpvS7t4jYLPmY1vYWa4P/bkhpMDMxwjigSP40bxmoqwIac5HXbb7qasvdmjz?=
 =?us-ascii?Q?65KvgvaBYAq7JntXh0x7AL1JLs63o0QnNVzYdlYZMSAxYO6GO4LDE+2HBFXb?=
 =?us-ascii?Q?1Kcpqn/O6CDO4qO4aJNVTGKSzM/XZiKt9/2Dp2k3KNNRUgglqmg9LLHdXQLC?=
 =?us-ascii?Q?1Jx1ogUVHqj7ZwcSTc3T1xnWZFy6ls/b9JopY5qCD3ljo2oGdwkWzqukFrpL?=
 =?us-ascii?Q?bLfCdPzq4HdaerbtanctONIIOLrphW8zI4B1juJU8OoqCoEXbziwqdgKG1rX?=
 =?us-ascii?Q?HgabD04M3ATwyU81T4r4d3UmLKDpDmI2CvHLuN5B9H2J+8qKlVmLZRCDuXLR?=
 =?us-ascii?Q?dXtcbnMlyx0NZvDFwPh/zVuXonyrQg7dOa4Kjpu0ru3U13OHf30mpdq1BCGM?=
 =?us-ascii?Q?G8/BgtpqmN6hzHoa4CIwZMANugq+o15UJkUhg4cS8XVvQN2HPBchS8cyA45W?=
 =?us-ascii?Q?KRRFvEtjCkBemKUgliYI8MB0woTV8FBdJmyTKuMecv0Q2hIGWdgha3093O9C?=
 =?us-ascii?Q?eWtIAzlUAE92v+uLZKg52NhGe2vLRyCkh0S0cfC12VH+f4oplLOA3noSyKCF?=
 =?us-ascii?Q?5pzL2Iw5e0ipslS5xoyKA3vN9277+VN050xXt3B0MDl9xs17OhSRTe7236sq?=
 =?us-ascii?Q?lAq44+c6IImQL7LuYXxo/wfJRdq6O2W6DJZeus2oFnuAoYKJFxHMeGdkdbTI?=
 =?us-ascii?Q?OKdG+y1w8K52im7drzvlYkV6+LXVgyX+Zk6qTXK7cFIJ071j+g02OsQZWTTC?=
 =?us-ascii?Q?AL4Lbvh2zxld94T6z+7J7wbd6pm4PWAghn1ptT+gkjfjvCnALZSrZMasMoQH?=
 =?us-ascii?Q?0hcvuc+LP98X6OyDSoQQJZiKyhNGeGmKpgMXYWepWQqg0iDF2cjDNspj0r3j?=
 =?us-ascii?Q?403wjw/Yzf6P0Y5/w5LewhabrqyTFSlPVW4qingJTIu2lgwAUHehtfXe0/1n?=
 =?us-ascii?Q?iezRO+DRcQDoeH/8/o35ve3RtQwRBZec4cedxfaKz1bWN5YtOcooEnKAL7VW?=
 =?us-ascii?Q?4aI8iObAFJtgEhHwdQmBsIy1c9n4y9v1E5taekivMHrpEvOMM6X9ME+Kg0oX?=
 =?us-ascii?Q?I0fry6g3hWKc7NYXngRBxSE9Y0xpAaPgqUBvzx+Gwdyihk+0QCBJ4op6w85c?=
 =?us-ascii?Q?Ja7BF+8IVmQMbTUG7Tw/3A+GQTgv2qh4JdHQO3RUl9ujIF/Ox2AvjpKRnBPb?=
 =?us-ascii?Q?snp3bpDcGIO7VqPpGhf7wvWx3p3pAFUst18yyQV0pwkylwQBCcXvgw6fqOb5?=
 =?us-ascii?Q?+nIxsS9BTgQFSxHGqKfKcvB32V5DtnXvp+B6qE+6TlSSryCsEaUTim92yXtD?=
 =?us-ascii?Q?sbnmEXRT4GREsKFRcDmfHmEthzf5zqunhsM4WRaVIRfyfklpA1yIJiuYTeMn?=
 =?us-ascii?Q?ktxHFg+6es0sJ1QrevPaNMBsybf4i/TGeah6XHCGVt312aJgFapm6mVsCj9c?=
 =?us-ascii?Q?jE/CEuwU4yOCvyU5WEJHvWueaVM6kqxrhaa17ej7tOXkjvV2ax4yeVwY7Nf5?=
 =?us-ascii?Q?E7c4an4bvWgcqKvytmMJ6DmdrjRmBxlqTjQo7ozRfKYpNCAMY6kYibk0ljdz?=
 =?us-ascii?Q?9uIz/tKfLUC1AgMtFp6R2L4=3D?=
Content-ID: <9229BB9BEB3D714F822A90DE58D530B0@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR15MB5354.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5408e1a-2e2a-4592-99bd-08db257367bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 16:36:19.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAnULjKxD6IEsNXN/owhlyR3XTFOwHXpKHXIptZMrMcc78W2Lx+538hGNtqtUW7t2BauG7Bd5gwWZOHc4K8O3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3813
X-Proofpoint-GUID: fG1dK5uky--z2FzXuhAqUGN7W2dl1zBh
X-Proofpoint-ORIG-GUID: fG1dK5uky--z2FzXuhAqUGN7W2dl1zBh
Content-Type: text/plain; charset="us-ascii"
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_08,2023-03-15_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 14, 2023, at 10:53 PM, David Vernet <void@manifault.com> wrote:
> 
> !-------------------------------------------------------------------|
>  This Message Is From an External Sender
> 
> |-------------------------------------------------------------------!
> 
> On Wed, Mar 15, 2023 at 10:28:56AM +0700, Bagas Sanjaya wrote:
>> On Mon, Mar 13, 2023 at 07:59:47AM -0500, David Vernet wrote:
>>> On Mon, Mar 13, 2023 at 04:44:59PM +0700, Bagas Sanjaya wrote:
>>>> On Fri, Mar 10, 2023 at 10:09:28AM -0800, Sreevani Sreejith wrote:
>>>>> From: Sreevani <ssreevani@meta.com>
>>>>> 
>>>>> Summary: Document that provides an overview of libbpf features for BPF
>>>>> application development.
>>>> 
>>>> It seems like you ignore some of my reviews at [1]. Anyway, I
>>>> repeat them here, augmenting my new comments.
>>> 
>>> Sreevani, please be sure to reply to and address all reviewers'
>>> comments. I've also requested that we not use these internal Meta tags
>>> on more than one occasion, so please be mindful of it for future
>>> patches, and take a bit of extra time to double check that you've
>>> addressed all reviewers' concerns. I also suggest reading over [0],
>>> which specifies that new versions of patches should include descriptions
>>> of what's changed from prior versions. Please see Joanne's patch set in
>>> [1] which serves as a very nice example.
>>> 
>>> [0]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
>>> [1]: https://lore.kernel.org/all/20230301154953.641654-1-joannelkoong@gmail.com/
>>> 
>>> Bagas -- just FYI, a quick git log would have shown that this is only
>>> Sreevani's second patch. I don't think she intentionally ignored
>>> anything. It's likely just an artifact of getting used to the kernel
>>> review process.
>> 
>> Oops, you mean this v3 is actually v2, right?
> 
> Oh, I just meant that this is her second patch submission to the Linux
> kernel in general, (the first was [0]), so she likely just accidentally
> forgot to address your comments rather than intentionally ignoring them.
> Of course, it's good that you highlighted them again here in v3, as they
> certainly need to be addressed.
> 
> [0]: https://lore.kernel.org/all/20221202221710.320810-2-ssreevani@meta.com/

Bagas, apologies for not addressing one of your comments. As David mentioned,
 it was not intentional. I am still getting used to filtering out comments from the rest
 of the documentation. 
> 
>> 
>>>> Why did you add heading overline and change the heading character marker?
>>> 
>>> I assume that Sreevani is following python documentation conventions [0], which
>>> suggest that #### with overline refers to the highest-level heading in a page.
>>> This is suggested in Sphinx documentation [1] as well.
>>> 
>>> [0]: https://devguide.python.org/documentation/markup/#sections 
>>> [1]: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections 
>> 
>> OK.
>> 
>>>> You may want to also add :lineos: option or manually add line numbers
>>>> if you add :emphasize-lines: so that readers can see the line number
>>>> it refers to.
>>> 
>>> What is :lineos:? I don't see it anywhere else in Documentation/ and if
>>> I add it, the docs build complains:
>>> 
>>> Documentation/bpf/libbpf/libbpf_overview.rst:177: WARNING: Error in "code-block" directive:
>>> unknown option: "lineos".
>>> 
>>> .. code-block:: C
>>>  :lineos:
>>>  :emphasize-lines: 6
>> 
>> You forget to indent both options (see [1]).
> 
> The indentation was correct ;-) The option is actually ":linenos", not
> ":lineos:". That said, it's a neat option, so thank you for pointing it
> out.
> 
>>> 
>>>  //...
>>>  struct task_struct *task = (void *)bpf_get_current_task();
>>>  struct task_struct *parent_task;
>>>  int err;
>>> 
>>>  err = bpf_core_read(&parent_task, sizeof(void *), &task->parent);
>>>  if (err) {
>>>    /* handle error */
>>>  }
>>> 
>>>  /* parent_task contains the value of task->parent pointer */
>>> 
>>> I personally think adding line numbers is overkill. The highlighting is
>>> already a nice touch, and gets the point across without the additional
>>> visual cue of line numbers.
>> 
>> But if the snippet above is instead long, how can one looking for the
>> emphasized line number when reading doc (especially in .rst source) other
>> than manually counting from the first line of the snippet? See
>> Documentation/RCU/rcubarrier.rst for example of manual line numbering
>> (and [2] for the related patch).
> 
> Well, that's a bit of a hypothetical problem given that in this case
> we're only talking about 6 lines ;-) In any case, I don't really mind
> one way or the other, but given that none of the other example
> codeblocks in the BPF docs have line numbers, I'd personally err on the
> side of not adding them here.
> 
>>>> BPF apps are application that use BPF program, right? I thought that
>>>> despite there is libbpf-rs, I still have to develop BPF apps in C.
>>> 
>>> It says that at the end of the paragraph?
>>> 
>> 
>> I was confused between BPF apps and BPF programs, since I was accustomed
>> that apps and programs refer to the same thing.
> 
> This is alluded to a bit earlier in this document:
> 
>> A BPF application consists of one or more BPF programs (either
>> cooperating or completely independent), BPF maps, and global
>> variables.
> 
> "Program" in the context of BPF has a very specific meaning. We need to
> improve our documentation on them, but see [1] for a bit more detail.
> The TL;DR is that the BPF program is the part that runs in kernel space.
> 
> [1]: https://www.kernel.org/doc/html/latest/bpf/libbpf/program_types.html#program-types-and-elf
> 
> Thanks,
> David

