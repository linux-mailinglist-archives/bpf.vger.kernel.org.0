Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E686C2425
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 22:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCTV4p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 17:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCTV4o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 17:56:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB2F2CFD9
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 14:56:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ek18so52538414edb.6
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679349401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0v7/Cp0u9KOMhQESeckbKoTNsLx0J5Dhx1lttgnIJw=;
        b=N2f8QYqtg7Av9htvT7Y5zKyP3wlgtPdKLR9sW2R7Fp2I3OZsUYwUi6WTt6hTmBEdS1
         u/mvUBdy6rrO+rV6U8GWORDtnmVCN5F4w5pkVkI7P2f7F66G73+gpapg+TbWcuZiFzm4
         Z/E1Uw6k8HkxCOfjWqZOXVfn4SsR8Tl1udzymrF4tMtq4Pf0BbvZciz3l8e1WBkm6wBb
         nO3OzFD9P1MLYEcLTUhagQgptej1/KontNJtW5VhCN0DynWXv+gmvLsEJbHNbb5Q5myf
         sga75tcFtO/d9yjwMmtwrlV8lxHMYSg1PnuD3s1AoygGRj+IJqemAKsQa1eDomp3Ybxa
         vUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679349401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0v7/Cp0u9KOMhQESeckbKoTNsLx0J5Dhx1lttgnIJw=;
        b=VgwJWcxQiimxi14sZRCfNOclQsxnqTvVlHSKtRhKaCkQc+2kMXr0iN7DIXi1AEwFls
         PuJ8jyXSdOIH+/LhSrixurfvKJsc4CJRZTUjUxOk/IjncYo9QdRB8N00Vp96EOEFaqUv
         TzXZSFOnBvjM+oUud/lxgdGRpLwnXSuWI1e9Q5AivOKCSiAwRA0dxSkc1gPD1Pf/0NY9
         v6kRLNz6SP7sijeQSqFutllrVdkQyXt0PPrV6PFm5kLbY6VyLFNHFfU/Za09rOTNZKAH
         x80wXd3EaD5+vB1ejYwLrZO5LJScSzhCC8r4LNhQb/rZO0ECgbm1Ny8as1ijW7w0aioh
         Cz4A==
X-Gm-Message-State: AO0yUKW3IdyrK/pMOgp2COuOui2/m0XjCe4eJnortE2IX6F3tj9DwWha
        TwDIMcLITDB5dCAE5Tytpvbqyc5jC+yl9t33VgU=
X-Google-Smtp-Source: AK7set8ZbHfUQ+x50qqXfXilWxjfNrSEQwbVhiMjKc841elo420je8nVMMfQOEj0HOR+WqvZfyrflGzcAKKIiM7qtKk=
X-Received: by 2002:a17:906:6613:b0:92e:a234:110a with SMTP id
 b19-20020a170906661300b0092ea234110amr271791ejp.3.1679349400700; Mon, 20 Mar
 2023 14:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAAFY1_4a5MC0-BkGcRx-5n-vdXZbjjrjEukwur+n4AOXFhMHFw@mail.gmail.com>
 <CAADnVQLcqDOzXPSUUNyFE=UJHBP-ZgOEqFfaGynTUL-jQnw-=w@mail.gmail.com>
 <CAAFY1_66-b063v+edsHPBbK6iuiE=KoY38=kr0FVzVLg5gkE_w@mail.gmail.com>
 <af9d6b81-b3d4-9f48-5ec2-da00c084bf28@huawei.com> <CAAFY1_5YwjwFAj53eoGNsD0gVukrVppf=b7cNznAJOcrhY-PEA@mail.gmail.com>
In-Reply-To: <CAAFY1_5YwjwFAj53eoGNsD0gVukrVppf=b7cNznAJOcrhY-PEA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 20 Mar 2023 14:56:29 -0700
Message-ID: <CAADnVQJ5MREnUTdU2D9hJCa4ktDTVnQcMgYmX-cGWiw2mSB9vA@mail.gmail.com>
Subject: Re: bpf_timer memory utilization
To:     Chris Lai <chrlai@riotgames.com>
Cc:     Hou Tao <houtao1@huawei.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 20, 2023 at 10:16=E2=80=AFAM Chris Lai <chrlai@riotgames.com> w=
rote:
>
> Hi,
>
> In my setup, both (LRU and HASH) are preallocated.
> Kernel verson: Linux version 5.17.12-300.fc36.x86_64
> I am doing load test via load generator (Spirent) to an DUT appliance.

The kernel is a bit old.
Can you try to repro on the latest kernel?
Not saying that it won't be fixed in the old kernel,
but it will help a lot if it's still there in the latest.

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

Since it's a preallocated hash map, it behaves
exactly the same way as LRU from timer destruction pov.

Could you create a selftest out of your program?
It doesn't have to be XDP and run real traffic.
The test can randomly populate a map in a loop.

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

Please check return values.

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

sizeo(struct bpf_hrtimer)=3D=3D96
so 16M timers is ~1.5G.
... memory for LRU is 7G and for hash is 34G.. it all sounds odd.
Since according to your code snippets both maps are preallocated,
so memory consumption should be the same.
Even if all 16M timers are active it's still 1.5G which cannot explain
the difference between 7G and 34G.

My current theory is that something is wrong with htab extra_elems logic.

Do you have other part of the code when you do:
bpf_map_update_elem(&flow_table, &in_ip_flow_tuple, ...);
to update _existing_ element in place?

Do you know that map_lookup_elem() returns a pointer to value
and any changes to that value are written in place?
There is no need to do update_elem() after you changed the value.
