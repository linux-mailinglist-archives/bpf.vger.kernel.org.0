Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE545266995
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 22:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgIKUhK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 16:37:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1942 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbgIKUhD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 11 Sep 2020 16:37:03 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BKZNm3022639;
        Fri, 11 Sep 2020 13:36:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=LJQ3TUc3bsSHO63NKPIir+UN7Xq1rAhTFGrI9Ewaa70=;
 b=h5ooT7c+Z3/n2EJ40i1NQ/PAGT0kFDpsclwqFu4/G2Joxt/Rg7VBkWt5KBkrP8ZJdsB2
 XG79bZnb7DembQPUIFIKg2n30QYkh4S0azFm5mHIHGA6epDcBaiox1ZCRE9BjrIuaFnb
 giCUuXuJtbFcU3qsU9lC0KmhBHo9wsaXdEY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33fjtd92rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Sep 2020 13:36:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 11 Sep 2020 13:36:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0LsOmiWbPGp+WEKVIBIllXLUh3KO+InGQ+N2AjRJWKbSmrn/ynb6olIj2j8/zXRnPVisdTPkxk/hFLfNegbPi6JylK8CuPtQo/NPpvbwcCY1L/wct1JJvg2Rp7IiikDttcg/F+2xJIVCpBSQWiJ1kN5kYY3YKTWYxtRZa3laUjprPedSJBI/AVCD1qXXp0Iwg+pTlOyOp978SBpihlMtPooCaCT4PAQ4dztjs+rHPs9JVn32cWEPypfHAV5vzJHaHRHHrRvBPj8oomWOZYojQmYbKdfpFj6r6EzYMluyHE9k/zBuBz4GQmHbhlpfuH3TrFxVrfBJRdrv1d0dT9msg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJQ3TUc3bsSHO63NKPIir+UN7Xq1rAhTFGrI9Ewaa70=;
 b=FedLM90q5PFmg/VETX452tTrRfMWueYes8+KJZ+wjFdGLTTALFVlucyCJyn1GHVJbZHBY92yZLuwgLLgTNohbO1ngKrZWOOyCY7GRyWUBJO58pG6XpBMW4O7miOMu9LS+bwl2qVPK3VQ/eDEMXUYlo5eexaNxFvZX6M93ioRn2diuYa+luIBe9Hj05PZTHvdPzShvNjkdOowkzH9XoxtrY0bKVEYdlSCXMP9R0+qhZvz1xpIMvOG5vfYCSMNxOnLlx88/zwauhDaYvVzKcFlyRdqNBpRFrRF8WZKngGwT4TOHU1ClWbol5iotMm/gwrK84rkp93zSCOzYE0JOKQqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJQ3TUc3bsSHO63NKPIir+UN7Xq1rAhTFGrI9Ewaa70=;
 b=WI/7sGxhECOCg7RwavpLaeNqVatonGqFqvBJ43V78lGgXr0a6IZwU6LXZrvKlbM+5XKVE+jk2qCr9VUor1zmMJaMVbICPlmigTZi+5Lia+YAla/9+Q6+7QbCbwUq/6oNue5jvICnCk7F70eyQyVBnH0LSn+cZhDhnVDtXu9qHrQ=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3716.namprd15.prod.outlook.com (2603:10b6:a03:1b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 20:36:41 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1400:be2f:8b3d:8f4d]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1400:be2f:8b3d:8f4d%7]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 20:36:41 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Behavior of pinned perf event array
Thread-Topic: Behavior of pinned perf event array
Thread-Index: AQHWenJYGYmcjdDcHU252iH5UN06WKlV7JOAgAAPaQCAAAonAIABdX6AgAeYrgCAAHgVgIAEdTgA
Date:   Fri, 11 Sep 2020 20:36:41 +0000
Message-ID: <9E8ACC53-12CD-42B5-8419-2ABDCE5967DA@fb.com>
References: <6CAD359B-F446-4C5D-9C71-3902762ED8D6@fb.com>
 <47929B19-E739-4E74-BBB7-B2C0DCC7A7F8@fb.com>
 <0fb36afb-6056-5e44-77d8-1ad57d82db1c@iogearbox.net>
 <BE639CE6-8566-4184-B386-7AEED22939FB@fb.com>
 <fae5ddc7-b7b5-e757-fdbb-2946d56caca3@iogearbox.net>
 <107FC288-D07C-4881-82BD-8FD29CE42290@fb.com>
 <DEBBD27D-188D-4EFD-8C04-838F54689587@fb.com>
In-Reply-To: <DEBBD27D-188D-4EFD-8C04-838F54689587@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.1)
authentication-results: iogearbox.net; dkim=none (message not signed)
 header.d=none;iogearbox.net; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:6a27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af629837-c7db-4654-1e58-08d8569263e0
x-ms-traffictypediagnostic: BY5PR15MB3716:
x-microsoft-antispam-prvs: <BY5PR15MB371615C3939110F5DB5D96AFB3240@BY5PR15MB3716.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5tOOXI4N5i8jqcM3Aq7rj07gitOkzQYm9UvsVDT6HLaP8mstzyGk1EHS5ELg+aIZs4WGx7h0Yhgkl1dk0DpHuy7po4XjygvzhPoUCsQhFZaFLku2LVgjTUOc7liLLrKLUVWO2yMbUttTK7CvNYYQ85cn7WZC437voRo2B4p8d6YAisdN0RAwP64t3pN0ICwYnpWYYtVTovE/we7ZYdwneFyNUQNKT1Bw74g+vFiQkibMQuOoPkTkD4RsCjffxyWpT/WCbIhN+pckctD8CgIRwj+Z6HHshHP+Q34CZrXSBsb/1IXKer5H1LGl3r1M/+tjOBRtazW/ZoXS/Md7W3yfag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(136003)(346002)(39860400002)(2616005)(86362001)(36756003)(4326008)(83380400001)(66476007)(66946007)(66446008)(64756008)(33656002)(91956017)(66556008)(76116006)(71200400001)(316002)(478600001)(53546011)(6916009)(6512007)(8676002)(186003)(5660300002)(8936002)(6506007)(2906002)(54906003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nEgWFf5aqbblzHsCqgM92x3s56kyeRk21+n3rYjHOUNl/5GSZ6wkm6Fa0Jsvw3uMR+pkpZ7BE88grTv6yK81twel+KxZN7JWfhXLB4AfqbPQ3x2W3eEjcG/dRU6iwUSZwhcKXBD8refMScuSat2EmsvA4INvmbiazidzZIzir2PjEuW1/L6Pvs4J58QYGsFww2/h4aFiH+9ha4q/OwUowp+KnWGDhvnykbco7j2ogcs9qjwdtHrerpl1W7RRfUwZlQGSWnT4ncTnTIx9mIDN9taJeTYsKRaAJs8yfTdIvavYH6oNQxM0MuTN3jLxD5Kzk86elcmEnDEkMbGYCXOoMcpkyEubxHdRqgjB5Y7hZqJvwEtUClrGIFPVTZ90pBtbc7iI0EPfpPkp8zGwmTUCgeElXX7hkG7TqTmI7egb+co9LjAtrYr4esUdwnbFdNaaAwO4Mu2uwT15vQkLSXoNw8hxuzcAiZov4dIuwzSJF2FSEwrFBqKXpE3vJgmsb2+YV3jhmKnCiKrltA92FRDYPeSC8spFX+7R36KYzoGv60KjixKFkYmqHJzpeEGA9/+ek6M9EPeoVOqvqfsfvJ1YYzm+FKfjmlgHlEUuA6/tCQK3mjfXG/tWLLuFMBkbpmwsezd3+ziJTzgr4HU8Qe00yad0oGEU9WWew9bWyvoSUoursvyyDDX5y5ELwHYjzWcy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B72E46B13BEF044386FE108A2D1E27CF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af629837-c7db-4654-1e58-08d8569263e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 20:36:41.1312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H75mI3z6hfQQz+8vpJoJomFNV1swA6AA2IYHEIdCn0eFGPmnlqoEsz6c6f1CYUBXbyhrS3EoinnfGOul4llrCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3716
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_10:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009110168
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 8, 2020, at 5:32 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Sep 8, 2020, at 10:22 AM, Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On Sep 3, 2020, at 2:22 PM, Daniel Borkmann <daniel@iogearbox.net> wrot=
e:
>>>=20
>>> On 9/3/20 1:05 AM, Song Liu wrote:
>>>>> On Sep 2, 2020, at 3:28 PM, Daniel Borkmann <daniel@iogearbox.net> wr=
ote:
>>>>>=20
>>>>> Hi Song,
>>>>>=20
>>>>> Sorry indeed missed it.
>>>>>=20
>>>>> On 9/2/20 11:33 PM, Song Liu wrote:
>>>>>>> On Aug 24, 2020, at 4:57 PM, Song Liu <songliubraving@fb.com> wrote=
:
>>>>>>>=20
>>>>>>> We are looking at sharing perf events amount multiple processes via
>>>>>>> pinned perf event array. However, we found this doesn't really work
>>>>>>> as the perf event is removed from the map when the struct file is
>>>>>>> released from user space (in perf_event_fd_array_release). This
>>>>>>> means, the pinned perf event array can be shared among multiple
>>>>>>> process. But each perf event still has single owner. Once the owner
>>>>>>> process closes the fd (or terminates), the perf event is removed
>>>>>>> from the array. I went thought the history of the code and found
>>>>>>> this behavior is actually expected (commit 3b1efb196eee).
>>>>>=20
>>>>> Right, that auto-cleanup is expected.
>>>>>=20
>>>>>>> In our use case, however, we want to share the perf event among
>>>>>>> different processes. I think we have a few options to achieve this:
>>>>>>>=20
>>>>>>> 1. Introduce a new flag for the perf event map, like BPF_F_KEEP_PE_=
OPEN.
>>>>>>> Once this flag is set, we should not remove the fd on struct file
>>>>>>> release. Instead, we remove fd in map_release_uref.
>>>>>>>=20
>>>>>>> 2. Allow a different process to hold reference to the perf_event
>>>>>>> via pinned perf event array. I guess we can achieve this by
>>>>>>> enabling for BPF_MAP_UPDATE_ELEM perf event array.
>>>>>>>=20
>>>>>>> 3. Other ideas?
>>>>>>>=20
>>>>>>> Could you please let us know your thoughts on this?
>>>>>=20
>>>>> One option that would work for sure is to transfer the fd to the othe=
r
>>>>> processes via fd passing e.g. through pipe or unix domain socket.
>>>> I haven't tried to transfer the fd, but it might be tricky. We need to
>>>> plan for more than 2 processes sharing the events, and these processes
>>>> will start and terminate in any order.
>>>>> I guess my question would be that it would be hard to debug if we kee=
p
>>>>> dangling perf event entries in there yb accident that noone is cleani=
ng
>>>>> up. Some sort of flag is probably okay, but it needs proper introspec=
tion
>>>>> facilities from bpftool side so that it could be detected that it's j=
ust
>>>>> dangling around waiting for cleanup.
>>>> With my latest design, we don't need to pin the perf_event map (neithe=
r
>>>> the prog accessing the map. I guess this can make the clean up problem
>>>> better? So we will add a new flag for map_create. With the flag, we
>>>=20
>>> I mean pinning the map itself or the prog making use of accessing the m=
ap
>>> is not the issue. Afaik, it's more the perf RB that is consuming memory=
 and
>>> can be dangling, so the presence of the /entry/ in the map itself which
>>> would then not be cleaned up by accident, I think this was the motivati=
on
>>> back then at least.
>>>=20
>>>> will not close the perf_event during process termination, and we block
>>>> pinning for this map, and any program accessing this map. Does this
>>>> sounds like a good plan?
>>>=20
>>> Could you elaborate why blocking pinning of map/prog is useful in this =
context?
>>=20
>> I was thinking, we are more likely to forget cleaning up pinned map. If =
the
>> map is not pinned, it will be at least cleaned up when all processes acc=
essing=20
>> it terminate. On the other hand, pinned map would stay until someone rem=
oves
>> it from bpffs. So the idea is to avoid the pinning scenario.=20
>>=20
>> But I agree this won't solve all the problems. Say process A added a few=
=20
>> perf events (A_events) to the map. And process B added some other events=
=20
>> (B_events)to the same map. Blocking pinning makes sure we clean up every=
thing
>> when both A and B terminates. But if A terminates soon, while B runs for=
 a=20
>> long time, A_events will stay open unnecessarily.=20
>>=20
>> Alternatively, we can implement map_fd_sys_lookup_elem for perf event ma=
p,=20
>> which returns an fd to the perf event. With this solution, if process A =
added=20
>> some events to the map, and process B want to use them after process A=20
>> terminates. We need to explicitly do the lookup in process B and holds t=
he fd=20
>> to the perf event. Maybe this is a better solution?
>=20
> Actually, this doesn't work. :( With map_fd_sys_lookup_elem(), we can get=
 a fd
> on the perf_event, but we still remove the event from the map in=20
> perf_event_fd_array_release(). Let me see what the best next step...

CC Andrii and bpf@

Andrii and I had some discussion on this.=20

Currently, I am working on something with a new flag BPF_F_SHARE_PE. I atta=
ched=20
the diff below.=20

On the other hand, we found current behavior of perf_event_array puzzling,=
=20
especially pinned perf_event_array (as pinning doesn't really pin the conte=
nt).=20
Therefore, we may consider changing the behavior without a flag?

Thanks,
Song


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

From f78720bbaec9aae3a44bd21e0902d5a215dfe0b0 Mon Sep 17 00:00:00 2001
From: Song Liu <songliubraving@fb.com>
Date: Tue, 11 Aug 2020 13:38:55 -0700
Subject: [PATCH 1/3] bpf: preserve fd in pinned perf_event_map

---
 include/uapi/linux/bpf.h       |  3 +++
 kernel/bpf/arraymap.c          | 31 +++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  3 +++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 90359cab501d1..b527a28a4ba5c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -413,6 +413,9 @@ enum {

 /* Enable memory-mapping BPF map */
        BPF_F_MMAPABLE          =3D (1U << 10),
+
+/* Share perf_event among processes */
+       BPF_F_SHARE_PE          =3D (1U << 11),
 };

 /* Flags for BPF_PROG_QUERY. */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index e046fb7d17cd0..3bb58fe3d444c 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -15,7 +15,7 @@
 #include "map_in_map.h"

 #define ARRAY_CREATE_FLAG_MASK \
-       (BPF_F_NUMA_NODE | BPF_F_MMAPABLE | BPF_F_ACCESS_MASK)
+       (BPF_F_NUMA_NODE | BPF_F_MMAPABLE | BPF_F_ACCESS_MASK | BPF_F_SHARE=
_PE)

 static void bpf_array_free_percpu(struct bpf_array *array)
 {
@@ -64,6 +64,10 @@ int array_map_alloc_check(union bpf_attr *attr)
            attr->map_flags & BPF_F_MMAPABLE)
                return -EINVAL;

+       if (attr->map_type !=3D BPF_MAP_TYPE_PERF_EVENT_ARRAY &&
+           attr->map_flags & BPF_F_SHARE_PE)
+               return -EINVAL;
+
        if (attr->value_size > KMALLOC_MAX_SIZE)
                /* if value_size is bigger, the user space won't be able to
                 * access the elements.
@@ -778,6 +782,26 @@ static int fd_array_map_delete_elem(struct bpf_map *ma=
p, void *key)
        }
 }

+static void perf_event_fd_array_map_free(struct bpf_map *map)
+{
+       struct bpf_array *array =3D container_of(map, struct bpf_array, map=
);
+       struct bpf_event_entry *ee;
+       int i;
+
+       if (map->map_flags & BPF_F_SHARE_PE) {
+               for (i =3D 0; i < array->map.max_entries; i++) {
+                       ee =3D READ_ONCE(array->ptrs[i]);
+                       if (ee)
+                               fd_array_map_delete_elem(map, &i);
+               }
+       } else {
+               for (i =3D 0; i < array->map.max_entries; i++)
+                       BUG_ON(array->ptrs[i] !=3D NULL);
+       }
+
+       bpf_map_area_free(array);
+}
+
 static void *prog_fd_array_get_ptr(struct bpf_map *map,
                                   struct file *map_file, int fd)
 {
@@ -1105,6 +1129,9 @@ static void perf_event_fd_array_release(struct bpf_ma=
p *map,
        struct bpf_event_entry *ee;
        int i;

+       if (map->map_flags & BPF_F_SHARE_PE)
+               return;
+
        rcu_read_lock();
        for (i =3D 0; i < array->map.max_entries; i++) {
                ee =3D READ_ONCE(array->ptrs[i]);
@@ -1119,7 +1146,7 @@ const struct bpf_map_ops perf_event_array_map_ops =3D=
 {
        .map_meta_equal =3D bpf_map_meta_equal,
        .map_alloc_check =3D fd_array_map_alloc_check,
        .map_alloc =3D array_map_alloc,
-       .map_free =3D fd_array_map_free,
+       .map_free =3D perf_event_fd_array_map_free,
        .map_get_next_key =3D array_map_get_next_key,
        .map_lookup_elem =3D fd_array_map_lookup_elem,
        .map_delete_elem =3D fd_array_map_delete_elem,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index 90359cab501d1..b527a28a4ba5c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -413,6 +413,9 @@ enum {

 /* Enable memory-mapping BPF map */
        BPF_F_MMAPABLE          =3D (1U << 10),
+
+/* Share perf_event among processes */
+       BPF_F_SHARE_PE          =3D (1U << 11),
 };

 /* Flags for BPF_PROG_QUERY. */
--
2.24.1


