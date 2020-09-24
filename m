Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971B2277AE2
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 23:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIXVBy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 17:01:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21162 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgIXVBx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Sep 2020 17:01:53 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OKj9Au016610;
        Thu, 24 Sep 2020 14:01:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=h7VQZrGvfL6hfrNTKQ8ZsmGF0/4joIDed090r4fTjBA=;
 b=Qq4hqmYyyFb7D/X8VN0dWhzMwwNrvhYb5jjRa7PE9YL4q/L2sezkjAeQgt84UqopJRY7
 WIvYjbEOQvWTlz+wImaZrJhyj6W7S3kiDAufuRpZg9JxHQWC7IThR8NV+2p96x9psfdq
 xzJngp9w8gPoGLCzfAtVWHJXD/PXr/OejLE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33qsp4m0k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Sep 2020 14:01:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Sep 2020 14:01:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6XRY3YfeKqbsMbcUL6YwINTkQXALvELnTqdG7sm9hYMjSpzNzvGXoRJD3RAjkhzJWlGoLCTis4WDGkmjyN8dzEnk9/Hv/3xjLaELarwWAzrOp0GYrLctmdEZHa9nGaQOXUimNaAYicndoXwx1W65+KTP6C7p3zjw9uw9VoTFQ7QIjY2ZQghVTn5/uMwN+UaaiNyj7dqS3pxpwBXf93i/WPqD7XEwjdrm5NnUvK2bMBzD4DXu7AKCkHdEqz61xuOChms3wWMIIVH/W7AoHCIq3iQuh/6KLPTzY7dUvGXzK/NSbLpKru0u6Mu1U4BYSOsOgdCKxkQuJxEoquPDY7DfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7VQZrGvfL6hfrNTKQ8ZsmGF0/4joIDed090r4fTjBA=;
 b=BAVhfiaZ9swchDKzzqtFHinK9GCTKFxh7i79mgra5SDEl01l3lHxMZg0ixwl6uGGH+Ed67i5PnSIKpVZ+FgCHw5PFDS7AkukFr3htru+NkZke7wFmJzXcxukpv0Y1qJY+durBPiFQUo1fQ9s/ULd2UMZdbv0/jNZwHxl5jvIQ+ahDHj3muwJG8KjnRBeCXm4utwAG9rJiUDiwV/Z2+hZEFEGNYH3vUpBBhgoeSEm94VxBLXeKcHFViJSL2YWXHWwufxGWuGHRfr7ncT967bk3DoOJI6b77lnAg8tCBr2LshYGNSP0/ZtnbunSQ6LEJCbpBd7GKvL40DVh40HWGfK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7VQZrGvfL6hfrNTKQ8ZsmGF0/4joIDed090r4fTjBA=;
 b=bNOzr7Ckh/DTBAL1hgD/wNCj7VxAgjUnw+09lXaZfRW5UqZZYdlf1b+LzWz+glPbbe8HCY69dZnKBclkxCGislIIhKXS+cq9R4CILjYIvBdEP1psDiYAqL9EJ3aUdfRZHKp0MufNKFoxNfnNQNPYl5yN9UINm6yKCEg4Og7KZaI=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2728.namprd15.prod.outlook.com (2603:10b6:a03:14c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 21:01:39 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1400:be2f:8b3d:8f4d]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1400:be2f:8b3d:8f4d%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 21:01:39 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Subject: Re: Behavior of pinned perf event array
Thread-Topic: Behavior of pinned perf event array
Thread-Index: AQHWenJYGYmcjdDcHU252iH5UN06WKlV7JOAgAAPaQCAAAonAIABdX6AgAeYrgCAAHgVgIAEdTgAgATe4gCADbXlAIABEksAgADA8wCAAA1DAA==
Date:   Thu, 24 Sep 2020 21:01:39 +0000
Message-ID: <F779A855-A188-49B8-B653-9CBB4B717EEE@fb.com>
References: <6CAD359B-F446-4C5D-9C71-3902762ED8D6@fb.com>
 <47929B19-E739-4E74-BBB7-B2C0DCC7A7F8@fb.com>
 <0fb36afb-6056-5e44-77d8-1ad57d82db1c@iogearbox.net>
 <BE639CE6-8566-4184-B386-7AEED22939FB@fb.com>
 <fae5ddc7-b7b5-e757-fdbb-2946d56caca3@iogearbox.net>
 <107FC288-D07C-4881-82BD-8FD29CE42290@fb.com>
 <DEBBD27D-188D-4EFD-8C04-838F54689587@fb.com>
 <9E8ACC53-12CD-42B5-8419-2ABDCE5967DA@fb.com>
 <CAEf4BzbDMRzHGyxqXoA+bt_QJvybrjLG1EW9xdYLbDTQ5jLbMA@mail.gmail.com>
 <8AF90C54-22F4-46D3-8D79-A6B002BF3F45@fb.com>
 <374342b3-9504-7ec3-ff73-54cf621c244a@iogearbox.net>
 <CAEf4Bza9e3RiZAS4EAxruYoyj4cccYR5jydhxLBnp__j=fkxjQ@mail.gmail.com>
In-Reply-To: <CAEf4Bza9e3RiZAS4EAxruYoyj4cccYR5jydhxLBnp__j=fkxjQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.1)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:cb37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70c929eb-eb28-4e26-95f8-08d860cd081f
x-ms-traffictypediagnostic: BYAPR15MB2728:
x-microsoft-antispam-prvs: <BYAPR15MB27282DA15A11DB01505E8D65B3390@BYAPR15MB2728.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqONp5l5yTMjhfLwd3nz9f6aIcO+LGuFOByRZj1rgV4p97JLubuo0A9f0M6C37WNCaKz0h4B4z+Bqtdz/ZaoimS/j5r1/Q7LFdTH/obR7TBCNUtHWQ6lzJB/XWd11PC9InyWu32+j8SahNnybgJIGgB/wQz6aRcoyCADHaqSP1AWsmVbpMGgOZqpjiGI/GV//r8hpq8RjOnl+uOEP2mVQBk5DeeCNH3ur+IasmYt6v4vZMSmsG1snk1bKCBPz3KlWJqy7Otrtxiv+gvfXME1ppfoHcRfI4xTyDH7St8MxaPW16cxAShDIR1XJJ75DlJ5pbM5aIqebWtLtE7JdP31nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(396003)(366004)(376002)(5660300002)(6486002)(66446008)(2906002)(66556008)(76116006)(66476007)(71200400001)(64756008)(8936002)(54906003)(66946007)(91956017)(6512007)(6916009)(2616005)(36756003)(4326008)(8676002)(33656002)(186003)(86362001)(316002)(53546011)(478600001)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /ntWD4Z22Cb6k4ke36Es8eReyLUH40ePRDMUbij89LtKkspcxSvXoDSmebKH5OwzYgsGqZKSK+4R/D27Ab5/choaAra1mJrijlZiI+FeDnCL5fpngQPxIPRIU9ZHA+BM1WRCo7BBphVImqiFbb7Pg7RpicsRGUqUGZs55G3fNVTV21CSFERluvvRlqRyxiwv1e3zbVqbhCsaUel6Am4vzTN+xP4qWd2QMNlZaLY5zeHO+LlebeDyz/LLl9GYlk8cyf40zhDSMJetUvpjQGcBVT/gQByZG78G9xJdsWTMFjfbNM3j5ReeHLBnGpOKb2oQvWTnAcbgO7SB8IlrI870SdbQb8Jr03NwzGzRQo5HsanMmaJZ07IKqA0ZC5ZCaZ3S86I5QRC0llk+qj5PsRBS0k8mlPRl6W4V0E6O9Fadhh5JcE4htmfgmsq7XqC33eeBzjJMFq/mGLVv0YdnTGzNAebMDSyQi8uVuYTkjMZuwSHjXS83ftNc9dOF58QQy2Bxsxt5OVoF7n/oWnEf1FSpD5afGgGgy1cj0zet47VNZOwpW8QCUPNxG4fkPA0DEJHiEyTCbdwAyhLQmJj/NmEfKFzTrYMTyE8bDbY2VdcFDzhLUyUqQT4vh+CP9xApS6HjlCchZbKeuEgX9v/xQ8f/HmT7t/jZRMDUbvMwPWId8Z0I5nW1a2YZ5gqzAtGM4jHW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07CBCDC9A269AA41B00B8858FA777240@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c929eb-eb28-4e26-95f8-08d860cd081f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 21:01:39.2016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajawg0HjK72gT8aV8F4tvk40kSE/Ankzp8782yZXP02pR2AOphKJUHxb0g2wDQCNZjHrfD8FSfHOT/TNYrAKHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2728
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_15:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240152
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 24, 2020, at 1:14 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> =
wrote:
>=20
> On Thu, Sep 24, 2020 at 1:43 AM Daniel Borkmann <daniel@iogearbox.net> wr=
ote:
>>=20
>> On 9/23/20 6:21 PM, Song Liu wrote:
>>>> On Sep 14, 2020, at 3:59 PM, Andrii Nakryiko <andrii.nakryiko@gmail.co=
m> wrote:
>>>> On Fri, Sep 11, 2020 at 1:36 PM Song Liu <songliubraving@fb.com> wrote=
:
>> [...]
>>>> Daniel, are you aware of any use cases that do rely on such a behavior
>>>> of PERV_EVENT_ARRAY?
>>>>=20
>>>> For me this auto-removal of elements on closing *one of a few*
>>>> PERF_EVENT_ARRAY FDs (original one, but still just one of a few active
>>>> ones) was extremely surprising. It doesn't follow what we do for any
>>>> other BPF map, as far as I can tell. E.g., think about
>>>> BPF_MAP_TYPE_PROG_ARRAY. If we pin it in BPF FS and close FD, it won't
>>>> auto-remove all the tail call programs, right? There is exactly the
>>>> same concern with not auto-releasing bpf_progs, just like with
>>>> perf_event. But it's not accidental, if you are pinning a BPF map, you
>>>> know what you are doing (at least we have to assume so :).
>>>>=20
>>>> So instead of adding an extra option, shouldn't we just fix this
>>>> behavior instead and make it the same across all BPF maps that hold
>>>> kernel resources?
>>>=20
>>> Could you please share your thoughts on this? I personally don't have
>>> strong preference one way (add a flag) or the other (change the default
>>> behavior). But I think we need to agree on the direction to go.
>>=20
>> My preference would be to have an opt-in flag, we do rely on the auto-re=
moval
>> of the perf event map entry on client close in Cilium at least, e.g. a m=
onitor
>> application can insert itself into the map to start receiving events fro=
m
>> the BPF datapath, and upon exit (no matter whether graceful or not) we d=
on't
>> consume any more cycles in the data path than necessary for events, and
>> from the __bpf_perf_event_output() we bail out right after checking the
>> READ_ONCE(array->ptrs[index]) instead of pushing data that later on no-o=
ne
>> picks up.
>=20
> Well, then that's settled. We can't break existing use cases.

Thanks Daniel and Andrii! I will draft the patch with a new flag.=20

Song


