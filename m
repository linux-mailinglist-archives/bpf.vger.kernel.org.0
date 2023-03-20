Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576206C1DD0
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 18:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjCTRZ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 13:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjCTRZm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 13:25:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04045399F0
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 10:21:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eg48so49585926edb.13
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1679332871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8A4r8U5liPTlsglNb78/CAj10Cavc1TZAv9Uk7JS3U=;
        b=e5BRJ65AVH6KYFnTGCyXmDsS2CHuBDrMA5FdgDFIKefaS/efULA/J4H1FIQL0svWI0
         uRbahWXN+jKusZu6h+0qaRgzaCkJ6Fs1kp9Rdz3G8YGJK22tdd9gUllZOALkHgNWDudQ
         Skn2HSw94FRYKYrSb/U6kpdMczf1vJ+i4Sqkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8A4r8U5liPTlsglNb78/CAj10Cavc1TZAv9Uk7JS3U=;
        b=AcRJwX+wmVPBCZAzj8KMIF7EcSREZQrE6yFnwAOhwXcjjEjzkq6ylXs32UQgdfNjE6
         BoT53eDPWwaMRTu6IXFgd0BGJ3miqhXAporA4daXqQitH28cVE/AMFYnQFEvmVGS1o3Q
         y60br3dUdWjprNWGU4XKwj+4QZWjgnRNvB/4uA7QEQIlOsrQuPyo0nYzC07R0jj9hwQG
         Bixle9jrbj8wp8wYxI1n41Lc2c1vok+R7Su2f0i3tUg8soSqMBZi28XwWi3AI49k5U8b
         S5irMko9qXSdgixGvFERjNKOi9IR44nltVNY0IpMX+ONOmh/vddAb96scCa0jryZYj/6
         d2Ww==
X-Gm-Message-State: AO0yUKXKLF1kTlJvJS5AJt/f7FjjAeG/K1MnD4wNjL2VbdZQtOFFu/xW
        FcPQyNjIbndHElIk8/6d40WdMVSLYUP+XkuRE77/tJJGaXZtw8wua9Y=
X-Google-Smtp-Source: AK7set+9vG9Q9r6BLeOmNJO6sBUFczWo5pQuNetrhY+h0YYC+61KiWSFhx6deGij/63zrxn99i7S0bb7u2+NB9Dvhr8=
X-Received: by 2002:a17:906:4dd3:b0:932:4d97:a370 with SMTP id
 f19-20020a1709064dd300b009324d97a370mr3986507ejw.14.1679332871205; Mon, 20
 Mar 2023 10:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAAFY1_4a5MC0-BkGcRx-5n-vdXZbjjrjEukwur+n4AOXFhMHFw@mail.gmail.com>
 <CAADnVQLcqDOzXPSUUNyFE=UJHBP-ZgOEqFfaGynTUL-jQnw-=w@mail.gmail.com>
 <CAAFY1_66-b063v+edsHPBbK6iuiE=KoY38=kr0FVzVLg5gkE_w@mail.gmail.com>
 <af9d6b81-b3d4-9f48-5ec2-da00c084bf28@huawei.com> <CAAFY1_5YwjwFAj53eoGNsD0gVukrVppf=b7cNznAJOcrhY-PEA@mail.gmail.com>
In-Reply-To: <CAAFY1_5YwjwFAj53eoGNsD0gVukrVppf=b7cNznAJOcrhY-PEA@mail.gmail.com>
From:   Chris Lai <chrlai@riotgames.com>
Date:   Mon, 20 Mar 2023 10:21:00 -0700
Message-ID: <CAAFY1_6A4E8NrX-P9F+kOw1q+_8k7PiTy-0T7h9MNiN3KZ3fdA@mail.gmail.com>
Subject: Re: bpf_timer memory utilization
To:     Hou Tao <houtao1@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

forgot to include the call back snippet
static int myTimerCallback(void *map, struct ip_flow_tuple *key,
struct ip_flow_entry *val) {
bpf_map_delete_elem(map, key);
return 0;
}

On Mon, Mar 20, 2023 at 10:16=E2=80=AFAM Chris Lai <chrlai@riotgames.com> w=
rote:
>
> Hi,
>
> In my setup, both (LRU and HASH) are preallocated.
> Kernel verson: Linux version 5.17.12-300.fc36.x86_64
> I am doing load test via load generator (Spirent) to an DUT appliance.
>
> Code snippet
>
> #define MAXIMUM_CONNECTIONS 3000000
> #define CALL_BACK_TIME 60000000000
>
> struct ip_flow_tuple {
> ...
> };
>
> struct ip_flow_entry {
> ...
> struct bpf_timer timer;
> };
>
> // HASH
> struct {
> __uint(type, BPF_MAP_TYPE_HASH);
> __uint(max_entries, MAXIMUM_CONNECTIONS);
> __type(key, struct ip_flow_tuple);
> __type(value, struct ip_flow_entry);
> } flow_table __attribute__((section(".maps"), used));
>
> // LRU
> struct {
> __uint(type, BPF_MAP_TYPE_LRU_HASH);
> __uint(max_entries, MAXIMUM_CONNECTIONS);
> __type(key, struct ip_flow_tuple);
> __type(value, struct ip_flow_entry);
> } flow_table __attribute__((section(".maps"), used));
>
> SEC("xdp")
> int testMapTimer(struct xdp_md *ctx) {
> ...
> struct ip_flow_tuple in_ip_flow_tuple =3D {
>    ...
> }
>
> struct ip_flow_entry *in_ip_flow_entry =3D
> bpf_map_lookup_elem(&flow_table, &in_ip_flow_tuple);
> if (in_ip_flow_entry =3D=3D NULL) {
>     struct ip_flow_entry in_ip_flow_entry_new =3D {};
>     bpf_map_update_elem(&flow_table, &in_ip_flow_tuple,
> &in_ip_flow_entry_new, BPF_ANY);
>     struct ip_flow_entry *flow_entry_value =3D
> bpf_map_lookup_elem(&flow_table, &in_ip_flow_tuple);
>
>     if (flow_entry_value) {
>         bpf_timer_init(&flow_entry_value->timer, &flow_table, 0);
>         bpf_timer_set_callback(&flow_entry_value->timer, myTimerCallback)=
;
>         bpf_timer_start(&flow_entry_value->timer, (__u64)CALL_BACK_TIME, =
0);
>     }
>
> }
> ...
>
> }
>
> On Fri, Mar 17, 2023 at 6:41=E2=80=AFPM Hou Tao <houtao1@huawei.com> wrot=
e:
> >
> >
> >
> > On 3/18/2023 12:40 AM, Chris Lai wrote:
> > > Might be a bug using bpf_timer on Hashmap?
> > > With same setups using bpf_timer but with LRU_Hashmap, the memory
> > > usage is way better: see following
> > >
> > > with LRU_Hashmap
> > > 16M capacity, 1 minute bpf_timer callback/cleanup..  (pre-allocation
> > > ~5G),  memory usage peaked ~7G (Flat and does not fluctuate - unlike
> > > Hashmap)
> > > 32M capacity, 1 minute bpf_timer callback/cleanup..  (pre-allocation
> > > ~8G),  memory usage peaked ~12G (Flat and does not fluctuate - unlike
> > > Hashmap)
> > In your setup, LRU hash map is preallocated and normal hash map is not
> > preallocated (aka BPF_F_NO_PREALLOC), right ? If it is true, could you =
please
> > test the memory usage of preallocated hash map ? Also could you please =
 share
> > the version of used Linux kernel and the way on how to create hash map =
and
> > operate on hash map ?
> > >
> > >
> > >
> > > On Thu, Mar 16, 2023 at 6:22=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > >> On Thu, Mar 16, 2023 at 12:18=E2=80=AFPM Chris Lai <chrlai@riotgames=
.com> wrote:
> > >>> Hello,
> > >>> Using BPF Hashmap with bpf_timer for each entry value and callback =
to
> > >>> delete the entry after 1 minute.
> > >>> Constantly creating load to insert elements onto the map, we have
> > >>> observed the following:
> > >>> -3M map capacity, 1 minute bpf_timer callback/cleanup, memory usage
> > >>> peaked around 5GB
> > >>> -16M map capacity, 1 minute bpf_timer callback/cleanup, memory usag=
e
> > >>> peaked around 34GB
> > >>> -24M map capacity, 1 minute bpf_timer callback/cleanup, memory usag=
e
> > >>> peaked around 55GB
> > >>> Wondering if this is expected and what is causing the huge increase=
 in
> > >>> memory as we increase the number of elements inserted onto the map.
> > >>> Thank you.
> > Do the addition and deletion of hash map entry happen on different CPU =
? If it
> > is true and bpf memory allocator is used (kernel version >=3D 6.1), the=
 memory
> > blow-up may be explainable. Because the new allocation can not reuse th=
e memory
> > freed by entry deletion, so the memory usage will increase rapidly. I h=
ad tested
> > such case and also written one selftest for such case, but it seems it =
only can
> > be mitigated [1], because RCU tasks trace GP is slow. If your setup is =
sticking
> > to non-preallocated hash map, you could first try to add
> > "rcupdate.rcu_task_enqueue_lim=3Dnr_cpus" in kernel bootcmd to mitigate=
 the problem.
> >
> > [1] https://lore.kernel.org/bpf/20221209010947.3130477-1-houtao@huaweic=
loud.com/
> > >> That's not normal. Do you have a small reproducer?
> > > .
> >
