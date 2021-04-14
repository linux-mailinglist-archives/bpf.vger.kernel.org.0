Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5844335F637
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 16:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348415AbhDNObH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 10:31:07 -0400
Received: from forward5-smtp.messagingengine.com ([66.111.4.239]:45193 "EHLO
        forward5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349746AbhDNObH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Apr 2021 10:31:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailforward.nyi.internal (Postfix) with ESMTP id 1E7DF1940DDE;
        Wed, 14 Apr 2021 10:30:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 14 Apr 2021 10:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=gEuClD6n9PhFhjO74qyVD763gagF5B/fvg/bR7uiD
        68=; b=rBqZKPmB6OFZKo3TY01SPdbFRcNXafJM+dkOpaMyVTeFrsMfn1WqNU5Nc
        ZArTiTQMHvm45LD9JqmNHCw0T/SllOE1pQHcYD2k/kMiafjd/+gjqBIRyK0AFL6V
        5pnmSDJX2aXLsBJQlku95cfz3lgcJINrqdAffhSlxo+9ZmF1iv9xD2xzq8KCPvyy
        GpI/2V74c8Mgicf+IOAhxf2IRyc0GE0N71APFWNFCzj+7h5mZoaS4z4I2R42qwKy
        N0eY9oxTs+xGJrrdc7YYDCE3lGHw/IXYMgKx+mNmWVP+Zvxe4crMy8HsHpWaTgDW
        tInVpanE4NeHhMpyBQcPaQA7eLqSA==
X-ME-Sender: <xms:lPx2YHngV6FSfkULsQ3fRAF9JK22XJLehHDNuDaI7YrGY0PSCRPRAg>
    <xme:lPx2YK1lmctBK9Tmtw8kaSrGm36Xo8mVp3IHaA1yLe8qQT7mWYKy70DredrsG-oBs
    1zE-BEsDIy29pomUCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeluddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheptfgrfhgr
    vghlucffrghvihguucfvihhnohgtohcuoehrrghfrggvlhguthhinhhotghosehusghunh
    htuhdrtghomheqnecuggftrfgrthhtvghrnhephfduueffveeludegveehgedvgefhvdeh
    feekgfeivdefleevgfefkeevfeeifeefnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucfkphepudekhedrudehfedrudejiedrudegkeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghfrggvlhguthhinhhotghosehusghunh
    htuhdrtghomh
X-ME-Proxy: <xmx:lPx2YNoQhjpxPuqMQIykvtFMcZifLZh992ZLm7dooL6HiZiAjhdtTw>
    <xmx:lPx2YPl0FDi89zR3KB_royBgaex1T9hZuD1gVJFye0b67PXPuBz7Og>
    <xmx:lPx2YF1InUHLSjZq644thiIqegXC2bG6L2hlqJoa11PuHNbJxquf1Q>
    <xmx:lfx2YGCBjIVIkFTaW5t_YfY5GUZoSJwCIKhRhib8J79pTg0EjnHADQ>
Received: from [10.6.3.156] (unknown [185.153.176.148])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6E00D1080066;
        Wed, 14 Apr 2021 10:30:44 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2 bpf-next][RFC] libbpf: introduce legacy kprobe events
 support
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
In-Reply-To: <CAEf4BzbPdH+pV9NpCW+piROOfCme=erGQOHs8XcA_e=pYcV2=g@mail.gmail.com>
Date:   Wed, 14 Apr 2021 11:30:42 -0300
Cc:     LKML BPF <bpf@vger.kernel.org>
X-Mao-Original-Outgoing-Id: 640103442.834541-c1ff2122fbfd4090ea7bd2e3437978cc
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F445042-0ECC-4654-B334-E2364B5B9B8D@ubuntu.com>
References: <CAEf4Bzap6qS9_HQZTHJsM-X2VZso+N5xMwa3HNG9ycMW4WXtQg@mail.gmail.com>
 <20210322180441.1364511-1-rafaeldtinoco@ubuntu.com>
 <4BB60234-7970-405C-9447-D19CA6564BC2@ubuntu.com>
 <CAEf4BzaimrGXFrfFVHvV53ta7NwDWsN0YHcDiVJELEnbdjmKdg@mail.gmail.com>
 <045DF0ED-10A2-4D9F-AA01-5CE7E3E95193@ubuntu.com>
 <CAEf4BzbPdH+pV9NpCW+piROOfCme=erGQOHs8XcA_e=pYcV2=g@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>=20
>>> So I don't get at all why you have these toggles, especially
>>> ALL_TOGGLE? You shouldn't try to determine the state of another =
probe.
>>> You always know whether you want to enable or disable your specific
>>> toggle. I'm very confused by all this.
>>=20
>> Yes, this was a confusing thing indeed and to be honest it proved to
>> be very buggy when testing with conntracker. What I=E2=80=99ll do (or =
I=E2=80=99m
>> doing) is to toggle ON to needed files before the probe is added:
>>=20
>> static inline int add_kprobe_event_legacy(const char* func_name, bool
>> retprobe)
>> {
>>        int ret =3D 0;
>>=20
>>        ret |=3D poke_kprobe_events(true, func_name, retprobe);
>>        ret |=3D toggle_kprobe_event_legacy_all(true);
>>        ret |=3D toggle_single_kprobe_event_legacy(true, func_name, =
retprobe);
>>=20
>>        return ret;
>> }
>>=20
>> 1) /sys/kernel/debug/tracing/kprobe_events =3D> 1
>> 2) /sys/kernel/debug/tracing/events/kprobes/enable =3D> 1
>> 3) /sys/kernel/debug/tracing/events/kprobes/%s/enable =3D> 1
>=20
> Ok, hold on. I don't think we should use those /enable files,
> actually. Double-checking what BCC does ([0]) and my local demo app I
> wrote a while ago, we use perf_event_open() to activate kprobe, once
> it is created, and that's all that is necessary.
>=20
>  [0] https://github.com/iovisor/bcc/blob/master/src/cc/libbpf.c#L1046

No, they are not needed. Those are enabling ftrace kprobe feature:

trace_events.c:
    event_create_dir()
        trace_create_file("enable") ->=20
            ftrace_enable_fops():
            .write =3D event_enable_write() -> =
ftrace_event_enable_disable()

And kprobe perf events works fine without playing with them as long as:
/sys/kernel/debug/tracing/kprobe_events is always 1 (should we enable
it by default or consider it is enabled and don=E2=80=99t change its =
value ?).

>>=20
>> Because of /sys/kernel/debug/tracing/events/kprobes/%s/enable. I=E2=80=99=
m
>> toggling it to OFF before removing the kprobe in kprobe_events, like
>> showed above.
>=20
> Alright, see above about enable files, it doesn't seem necessary,
> actually. You use poke_kprobe_events() to add or remove kprobe to the
> kernel. That gives you event_name and its id (from
> /sys/kernel/debug/tracing/events/kprobes/%s/id). You then use that id
> to create perf_event and activate BPF program:

Yes, with a small reservation I just found out: function names might
change because of GCC optimisations.. In my case I found out that:

# cat /proc/kallsyms | grep udp_send_skb
ffffffff8f9e0090 t udp_send_skb.isra.48

udp_send_skb probe was not always working because the function name
was changed. Then I saw BCC had this issue back in 2018 and is
fixing it now:

https://github.com/iovisor/bcc/issues/1754
https://github.com/iovisor/bcc/pull/2930

So I thought I could do the same: check if function name is the same
in /proc/kallsyms or if it has changed and use the changed name if
needed (to add to kprobe_events).

Will include that logic and remove the =E2=80=98enables=E2=80=99.

>=20
> And that should be it. It doesn't seem like either BCC or my example
> (which I'm sure worked last time) does anything with /enable files and
> I'm sure all that works.

First comment.

>=20
> [...]
>=20
>>>>>     return bpf_program__attach_kprobe(prog, retprobe, func_name);
>>>>> }
>>>>=20
>>>> I=E2=80=99m assuming this is okay based on your saying of detecting =
a feature
>>>> instead of using the if(x) if(y) approach.
>>>>=20
>>>>> @@ -11280,4 +11629,7 @@ void bpf_object__destroy_skeleton(struct
>>>>> bpf_object_skeleton *s)
>>>>>      free(s->maps);
>>>>>      free(s->progs);(),
>>>>>      free(s);
>>>>> +
>>>>> +     remove_kprobe_event_legacy("ip_set_create", false);
>>>>> +     remove_kprobe_event_legacy("ip_set_create", true);
>>>>=20
>>>> This is the main issue I wanted to show you before continuing.
>>>> I cannot remove the kprobe event unless the obj is unloaded.
>>>> That is why I have this hard coded here, just because I was
>>>> testing. Any thoughts how to cleanup the kprobes without
>>>> jeopardising the API too much ?
>>>=20
>>> cannot as in it doesn't work for whatever reason? Or what do you =
mean?
>>>=20
>>> I see that you had bpf_link__detach_perf_event_legacy calling
>>> remove_kprobe_event_legacy, what didn't work?
>>>=20
>>=20
>> I=E2=80=99m sorry for not being very clear here. What happens is =
that, if I
>> try to remove the kprobe_event_legacy() BEFORE:
>>=20
>> if (s->progs)
>>        bpf_object__detach_skeleton(s);
>> if (s->obj)
>>        bpf_object__close(*s->obj);
>>=20
>> It fails with generic write error on kprobe_events file. I need to
>> remove legacy kprobe AFTER object closure. To workaround this on
>> my project, and to show you this issue, I have come up with:
>>=20
>> void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
>> {
>>         int i, j;
>>         struct probeleft {
>>                 char *probename;
>>                 bool retprobe;
>>         } probesleft[24];
>>=20
>>         for (i =3D 0, j =3D 0; i < s->prog_cnt; i++) {
>>                 struct bpf_link **link =3D s->progs[i].link;
>>                 if ((*link)->legacy.name) {
>>                         memset(&probesleft[j], 0, sizeof(struct =
probeleft));
>>                         probesleft[j].probename =3D =
strdup((*link)->legacy.name);
>>                         probesleft[j].retprobe =3D =
(*link)->legacy.retprobe;
>>                         j++;
>>                 }
>>         }
>>=20
>>         if (s->progs)
>>                 bpf_object__detach_skeleton(s);
>>         if (s->obj)
>>                 bpf_object__close(*s->obj);
>>         free(s->maps);
>>         free(s->progs);
>>         free(s);
>>=20
>>         for (j--; j >=3D 0; j--) {
>>                 remove_kprobe_event_legacy(probesleft[j].probename, =
probesleft[j].retprobe);
>>                 free(probesleft[j].probename);
>>         }
>> }
>>=20
>> Which, of course, is not what I=E2=80=99m suggesting to the lib, but =
shows
>> the problem and gives you a better idea on how to solve it not
>> breaking the API.
>>=20
>=20
> bpf_link__destroy() callback should handle that, no? You'll close perf
> event FD, which will "free up" kprobe and you can do
> poke_kprobe_events(false /*remove */, ...). Or am I still missing
> something?

I could only poke_kprobe_events() to remove the kprobe after
bpf_oject__close(), or I would get an I/O error on kprobe_events.
Not sure if after map destroy or program exit.

-rafaeldtinoco

