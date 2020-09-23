Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCEF275D41
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 18:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIWQWJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 12:22:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIWQWJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Sep 2020 12:22:09 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NGJCEK000961;
        Wed, 23 Sep 2020 09:21:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/p+3hoMiEH4AbIZNA4uTV2tvlCPzLw30ceVdMx9POOY=;
 b=I/L621SJdvh3jz/BUYm/QgvWStAxlrCRbZ1NnikMjFWEcjPVYKKuIJTil/AJF1Aa7QB4
 Gvff+EBbMiovA/wJEnWIf+tnzpidg9+aigpZ+GoI9wt1g3cJwEZUtJFHTCzvHA//gYc/
 DD5xqW9ygHtcWHEEQ3q2cO/JRu+oGIdqz0w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33qsp4vf90-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 23 Sep 2020 09:21:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 23 Sep 2020 09:21:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLy+XIJ+sl0z0LHRWLCwEHExx9tN8B9YdXcXG8W5XNepTGeg4nTc+yhDyeBP4Pa9ZrsHVT+Gjj2OasVlavBJXpqm2qZ+MwRWA5BZZ0uToeVde8Db/oQB0hP3sV9MI5VZq71qQG9PUmvtPxfVrAnI5r8MTyd+ukMNFK77r6g+OJsrJtyvsQBbg2TbsYpThXuJeWOWPxw9gvUcEP/HJ1td9SpFqqaz8esjxb+hMWgJJSZTLAmwdckzlszKl1nXnAj+W2G6gFxbxGaTa8UWU2TPADIFk13U0an4Yc8QDvq27yviN4CAyfwcb4Tk1vho0ePmU/+uGqYEp0vKg5kkLP3q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p+3hoMiEH4AbIZNA4uTV2tvlCPzLw30ceVdMx9POOY=;
 b=Ib4sYzkpPp7S8Uj3ZbjLoqVwKINyzc7M67amxND2axtqDP4dOm8tVVVElHvXLWYl4sW8ImDgMATOXbm87Ug0e3okqxB+WnfVhS1RRtIfEO8SDVTRKnyZoqX+yAaYeGPa5k0TOzZiY6NyD3cS++iA5ysHlN4XebFzmziLWS4ZB1OkfYKB4OGg97IJ5jJlSPIjuROydBuu0QItx+z3nyDxitLTCm5OiQqmVSr3EvAOmSFZy//YONtHdw1+HESoU0YR8nusjkbFGZZFGMDR8Mka2vyDrLOQ0AMNOteP1VrRxCMi4+yJlIO2Fv4EtRukce1Zx2J/q9kOoiFhOYBbVG3rkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p+3hoMiEH4AbIZNA4uTV2tvlCPzLw30ceVdMx9POOY=;
 b=Ogw5OLrVXKSQ9Qt7lQn2TEv87ZtbnY7fzjP5QydGV6gdRXSGxC3cgQhxr8iE/pFaL7wjA4kRNMFdDAPJS/Pul1nSF3OaBJbKr+VObfY7f0B8feaEG1x+YjD5UdGIe/CmSOukx8fQ2FiK5R2+Z/X6zPlBk3VoBZKqoX0IhN4b+v0=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2696.namprd15.prod.outlook.com (2603:10b6:a03:156::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 23 Sep
 2020 16:21:50 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1400:be2f:8b3d:8f4d]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1400:be2f:8b3d:8f4d%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 16:21:50 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: Behavior of pinned perf event array
Thread-Topic: Behavior of pinned perf event array
Thread-Index: AQHWenJYGYmcjdDcHU252iH5UN06WKlV7JOAgAAPaQCAAAonAIABdX6AgAeYrgCAAHgVgIAEdTgAgATe4gCADbXlAA==
Date:   Wed, 23 Sep 2020 16:21:50 +0000
Message-ID: <8AF90C54-22F4-46D3-8D79-A6B002BF3F45@fb.com>
References: <6CAD359B-F446-4C5D-9C71-3902762ED8D6@fb.com>
 <47929B19-E739-4E74-BBB7-B2C0DCC7A7F8@fb.com>
 <0fb36afb-6056-5e44-77d8-1ad57d82db1c@iogearbox.net>
 <BE639CE6-8566-4184-B386-7AEED22939FB@fb.com>
 <fae5ddc7-b7b5-e757-fdbb-2946d56caca3@iogearbox.net>
 <107FC288-D07C-4881-82BD-8FD29CE42290@fb.com>
 <DEBBD27D-188D-4EFD-8C04-838F54689587@fb.com>
 <9E8ACC53-12CD-42B5-8419-2ABDCE5967DA@fb.com>
 <CAEf4BzbDMRzHGyxqXoA+bt_QJvybrjLG1EW9xdYLbDTQ5jLbMA@mail.gmail.com>
In-Reply-To: <CAEf4BzbDMRzHGyxqXoA+bt_QJvybrjLG1EW9xdYLbDTQ5jLbMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.1)
authentication-results: iogearbox.net; dkim=none (message not signed)
 header.d=none;iogearbox.net; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:cb37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dd452cc-794a-4bcf-ea89-08d85fdcc707
x-ms-traffictypediagnostic: BYAPR15MB2696:
x-microsoft-antispam-prvs: <BYAPR15MB2696747FF3BFBE4FFF85D10DB3380@BYAPR15MB2696.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GBXG5g/UCfLH5HsgNefd8QBuqpgPgFabY6mlv+WqZE2HaLPIdUZbkHcr1S2K7j1m+PBVhIIksQwPLMGNL/fZFXOXxcU/86kNqfVJ6/NntYGTyLuoFp2pDNnUgKuvCKaWM6B7T8JmO/Vd6a+5oQvD2uRTmuU1ifjWY7W8DjhSrrHTapEj+jOZQCCBZmGmcMBrVVwWoRZLhKwQrp9ifpjdaQCAtWn+Yqg7RJljJOC2FELLE7c2Ob6eTDSxbaDCn30Ht7ZgooHaqiF5DRRlDEpbEXsP6i6i8p/Ay0JAaiKn35SXKyE7UVyK0A+4SHY0Bry5A6KsgprYZr7OP0VUXBc/nY+xvubjOJ6DFOJ0lXcqhXdXWArUnkV0Ddmv2HOU6XBZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(366004)(346002)(396003)(33656002)(71200400001)(5660300002)(186003)(86362001)(6512007)(36756003)(2616005)(8936002)(316002)(8676002)(6486002)(76116006)(91956017)(66446008)(66946007)(66476007)(64756008)(2906002)(4326008)(54906003)(6506007)(66556008)(53546011)(6916009)(83380400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VsnKR7aA3gH8/1ByMCnncCMlFE/Vk+/VJMtfyHr6A8Gq1itDWrN4OWuTxr2Fl1Lm7TJinWTJVd9IZnO6lrvBS8DwZfDrSIbPTI4krKfz4ttYWojfadqoEYYeqNyp5weItRH8yvesfLtwop92pGtEAspkdgWeYQckOwkGnVajMnKxXSbZ1vQm8uNTyXeOA7LTj63oYsHLJRab5HdNBpsi9VM6aaSAIjRk69B8T44AMEYuVsWOcbSjOgKBiwl4iiGmyghGjE56I/s8SGVQfPqXgCrkcqfF2SEH52W5HzH/CtvWzQbi4oa6KYzkPLwGEgnLL3R8qKcgTHeoe02Lzd4md+7v/GsKkmKS/W4yPwwuF+7n7Anuyx5RrsiiXF/dOvXKuAP9bd6svBAv+4Y/NbdW4lBHfGS1VywsZ8fG7uQkaTbHx1L/3gIKgTfFu7BC4SckE0RoQVSFCz8N5jo3r5bpG7SpOnUQ2LALcfVMETFvSN8yESL6l2IflZHreabuLD31AVLq1cUGbTp45dsJC8js7WCuxCs27O6NhTjCOE2COJLi+byIVP2lmnfn9ugOp67GuyCUgAMx5V5Pdi8bbFZBcvVYz20YCKhzI7ZAGheI0hbtPObHvxyQeVJQFwha/srcXykHkE6s4gJZ8izT0bTFnxCmUfZcqCVVa17KYtI5wo7OogquJi4PJDS7HsRykgFg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EF7E02A66FC7BD4589AD2C65ECCEED98@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd452cc-794a-4bcf-ea89-08d85fdcc707
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 16:21:50.9024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2kEnAriv+C2Bwv3Zj8YdMVso9MMftCMn2KZBydKtfJf7UjIp2Ns8Zt2M+magFMz/IUQmY2nL5GYxASpSuRHjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2696
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_12:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

> On Sep 14, 2020, at 3:59 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> =
wrote:
>=20
> On Fri, Sep 11, 2020 at 1:36 PM Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On Sep 8, 2020, at 5:32 PM, Song Liu <songliubraving@fb.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On Sep 8, 2020, at 10:22 AM, Song Liu <songliubraving@fb.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Sep 3, 2020, at 2:22 PM, Daniel Borkmann <daniel@iogearbox.net> wr=
ote:
>>>>>=20
>>>>> On 9/3/20 1:05 AM, Song Liu wrote:
>>>>>>> On Sep 2, 2020, at 3:28 PM, Daniel Borkmann <daniel@iogearbox.net> =
wrote:
>>>>>>>=20
>>>>>>> Hi Song,
>>>>>>>=20
>>>>>>> Sorry indeed missed it.
>>>>>>>=20
>>>>>>> On 9/2/20 11:33 PM, Song Liu wrote:
>>>>>>>>> On Aug 24, 2020, at 4:57 PM, Song Liu <songliubraving@fb.com> wro=
te:
>>>>>>>>>=20
>>>>>>>>> We are looking at sharing perf events amount multiple processes v=
ia
>>>>>>>>> pinned perf event array. However, we found this doesn't really wo=
rk
>>>>>>>>> as the perf event is removed from the map when the struct file is
>>>>>>>>> released from user space (in perf_event_fd_array_release). This
>>>>>>>>> means, the pinned perf event array can be shared among multiple
>>>>>>>>> process. But each perf event still has single owner. Once the own=
er
>>>>>>>>> process closes the fd (or terminates), the perf event is removed
>>>>>>>>> from the array. I went thought the history of the code and found
>>>>>>>>> this behavior is actually expected (commit 3b1efb196eee).
>>>>>>>=20
>>>>>>> Right, that auto-cleanup is expected.
>>>>>>>=20
>>>>>>>>> In our use case, however, we want to share the perf event among
>>>>>>>>> different processes. I think we have a few options to achieve thi=
s:
>>>>>>>>>=20
>>>>>>>>> 1. Introduce a new flag for the perf event map, like BPF_F_KEEP_P=
E_OPEN.
>>>>>>>>> Once this flag is set, we should not remove the fd on struct file
>>>>>>>>> release. Instead, we remove fd in map_release_uref.
>>>>>>>>>=20
>>>>>>>>> 2. Allow a different process to hold reference to the perf_event
>>>>>>>>> via pinned perf event array. I guess we can achieve this by
>>>>>>>>> enabling for BPF_MAP_UPDATE_ELEM perf event array.
>>>>>>>>>=20
>>>>>>>>> 3. Other ideas?
>>>>>>>>>=20
>>>>>>>>> Could you please let us know your thoughts on this?
>>>>>>>=20
>>>>>>> One option that would work for sure is to transfer the fd to the ot=
her
>>>>>>> processes via fd passing e.g. through pipe or unix domain socket.
>>>>>> I haven't tried to transfer the fd, but it might be tricky. We need =
to
>>>>>> plan for more than 2 processes sharing the events, and these process=
es
>>>>>> will start and terminate in any order.
>>>>>>> I guess my question would be that it would be hard to debug if we k=
eep
>>>>>>> dangling perf event entries in there yb accident that noone is clea=
ning
>>>>>>> up. Some sort of flag is probably okay, but it needs proper introsp=
ection
>>>>>>> facilities from bpftool side so that it could be detected that it's=
 just
>>>>>>> dangling around waiting for cleanup.
>>>>>> With my latest design, we don't need to pin the perf_event map (neit=
her
>>>>>> the prog accessing the map. I guess this can make the clean up probl=
em
>>>>>> better? So we will add a new flag for map_create. With the flag, we
>>>>>=20
>>>>> I mean pinning the map itself or the prog making use of accessing the=
 map
>>>>> is not the issue. Afaik, it's more the perf RB that is consuming memo=
ry and
>>>>> can be dangling, so the presence of the /entry/ in the map itself whi=
ch
>>>>> would then not be cleaned up by accident, I think this was the motiva=
tion
>>>>> back then at least.
>=20
> Daniel, are you aware of any use cases that do rely on such a behavior
> of PERV_EVENT_ARRAY?
>=20
> For me this auto-removal of elements on closing *one of a few*
> PERF_EVENT_ARRAY FDs (original one, but still just one of a few active
> ones) was extremely surprising. It doesn't follow what we do for any
> other BPF map, as far as I can tell. E.g., think about
> BPF_MAP_TYPE_PROG_ARRAY. If we pin it in BPF FS and close FD, it won't
> auto-remove all the tail call programs, right? There is exactly the
> same concern with not auto-releasing bpf_progs, just like with
> perf_event. But it's not accidental, if you are pinning a BPF map, you
> know what you are doing (at least we have to assume so :).
>=20
> So instead of adding an extra option, shouldn't we just fix this
> behavior instead and make it the same across all BPF maps that hold
> kernel resources?

Could you please share your thoughts on this? I personally don't have=20
strong preference one way (add a flag) or the other (change the default
behavior). But I think we need to agree on the direction to go.=20

Thanks,
Song

[...]=
