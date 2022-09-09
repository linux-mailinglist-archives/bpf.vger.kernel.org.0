Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749965B3CEE
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIIQZT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 12:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIIQZS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 12:25:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629D0EE9BD
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 09:25:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s14so2285043plr.4
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=SpEK7gZPEIyHGv8vHRGonzyJ+PSqXxfGkiWJafoPgb8=;
        b=X9iiUJ1y0CofjHQbsKm0ou8Z/KgBqNlCDi7vdXD6Nw298dVhBCWc6FgukRW2hsazCt
         QnKTBjcIi6k8k9evcK+N2xhUdY/fu6YvH8w2M4o64AVyDGjFX0RQB/idrqKJUMoQ8Ns9
         3lA2qd4262Tfmvm/Zb5jclbg07MY02KwPb2klSEc8QP2C8WgHfLksEGORQydzkRCCDQ5
         2/nNdGleA60wZey9SvjQXKf0tPcMRnDpbk5u4+2rnLsot2dEw1i0K/Nb4H7TfalgQ/iT
         Pv/eCiASu6jR14xbeXPI/ikeH9zpU827w+nOHUnZ/nFdnLcfysCzc4R8aBfr/eSyrAgF
         63Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SpEK7gZPEIyHGv8vHRGonzyJ+PSqXxfGkiWJafoPgb8=;
        b=gW74UpfajiFkcMObSawU4nMBkMLIobuwdZogXafVG84Nu9YxMpsMMywXEEj6VDIHs2
         1nlRq3ylmGCkSi+QR/0fjAIPUJZNVQHu54mD/16hMB1KbYPS9ccVY8cMOwnh45rSJx9r
         y4IubHCA4RbzppVjrSCLZ8cs3PmJ+6XIgq8WEq/sEgfBCqNwGVKBDWiybzYgAROFgd3T
         buIr1AVniyNKQ8TaBG99wgLQojFyRNPzEX68CKOqquNxQY2JDujMTVSZZmc/5JUtnBg7
         PX3ZGmpPUhb+Lovj8DZ3H7FvLrPXQGzzDwiPIyR2gZvnLjKGUHhmXdc82gsZpIHblFjr
         +prg==
X-Gm-Message-State: ACgBeo1VvZeLQjsOTQcB6tDvIVLWuVxy0L85blUIrxfgzHUfs6x4TZQr
        k4hY0lmXGP4VPJODZlhHhvLCb6we5d9PbW6GziQX+g==
X-Google-Smtp-Source: AA6agR4rfmSDYdS+ibUc7O8W2Asz/RTTLFEwj80f/ievSA9Gp4mnvhwt+h+Mh5i1zFppQTmyC2TwMWIYc1en5EiWjjQ=
X-Received: by 2002:a17:902:c951:b0:176:d421:7502 with SMTP id
 i17-20020a170902c95100b00176d4217502mr14632937pla.72.1662740716534; Fri, 09
 Sep 2022 09:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220908183952.3438815-1-mj@hunetr.com> <YxpmmepVMXXcaNfh@google.com>
 <CAK0nC2VpY-ag_OJr+mF=WGGAxUEwE6bDeB5mMmMJoSVp4i4iAQ@mail.gmail.com>
 <YxqnWuH8LRBDlFRV@google.com> <CAK0nC2VSBn3onXW2LfHdH4c+T6qCfcWHPE99QAV5pjqFj_pMUg@mail.gmail.com>
In-Reply-To: <CAK0nC2VSBn3onXW2LfHdH4c+T6qCfcWHPE99QAV5pjqFj_pMUg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 9 Sep 2022 09:25:05 -0700
Message-ID: <CAKH8qBs-V-YB+hjDgARVcHO_HTz0__GFS_OU1vs_5e07zd3V8Q@mail.gmail.com>
Subject: Re: [PATCH] bpftool: output map/prog indices on `gen skeleton`
To:     Marcelo Juchem <juchem@gmail.com>
Cc:     bpf@vger.kernel.org, Marcelo Juchem <mj@hunetr.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 8, 2022 at 8:43 PM Marcelo Juchem <juchem@gmail.com> wrote:
>
> Indeed, that works for this case. And yes, I do need something like load-=
with-fallbak.
>
> Let me pick your brain on the API, if you don't mind. Perhaps I can do al=
l I need with the current API:
>
> - I read the 1.0 roadmap document and unless I misunderstood something, i=
t seems that there are problems with loading individual programs and one sh=
ould lean towards loading the whole object at once. Is that the case? I'm m=
ostly concerned with a good way to implement load_with_fallback.

I'm not 100% sure about the roadmap, a haven't looked at it for a
while, but from the latest movement on libbpf:

You can control autoloading with either bpf_program__set_autoload or
doing SEC("?fentry/tcp_recvmsg").

So you can probably do the following (which won't load those progs by defau=
lt):

SEC("?fentry/tcp_recvmsg") int tcp_recvmsg_old(...) {}
SEC("?fentry/tcp_recvmsg") int tcp_recvmsg_new(...) {}

Then open the obj, enable autoload for tcp_recvmsg_new, and try to
load. If it fails, disable autoload for tcp_recvmsg_new, and retry
with autoload=3Dtrue for tcp_recvmsg_old.

But if you can do compilation tricks to have two separate obj files
with different versions that you can try to load in order, that might
be easier. I guess it depends on what you're trying to do. Here at G
we use both tricks for different programs, some have v1/v2/vX
suffixes, for some we selectively enable/disable parts of the obj
file.

> - from bpf_prog_skeleton I have access to both the bpf_program and the bp=
f_link. Is there a way to get the bpf_link if all I have is a bpf_program *=
 (assuming it's already attached)? Using the enums as the selector I can de=
finitely do that (gives me direct access to bpf_prog_skeleton);

Not that I see. I feel like with the way it's currently generated, the
only clean way is to std::map<bpf_program *, bpf_link *> somewhere.
(casting progs to struct bpf_program * and treating them as an array
might be an option, but it depends on the skeleton layout).
But that might be a valid use-case for your enums here. Or, instead of
enums, maybe generate the following skeleton?

union {
  struct {
    struct bpf_program *a;
    struct bpf_program *b;
  } progs;
  struct bpf_program *prog_list[2];
}
union {
  struct {
    struct bpf_link *a;
    struct bpf_link *b;
  } links;
  struct bpf_link *link_list[2];
}

That should maintain the mapping? Andrii (CC'ed) might give you better
suggestions.

> - can I selectively detach and unload some programs, but not others, in a=
 reliable and safe manner? I ask mostly because of the 1.0 deprecation that=
 I heard is going on, and I'm unsure which parts of the API are stable and =
which are going away. Right now I detach and destroy everything using the h=
igh level helpers from the generated skeleton, but I have some legitimate n=
eed to load a set of programs then unload a subset of them after some initi=
al discovery is performed.

You can definitely selectively detach/unload; maybe not through
skeleton, but definitely via libbpf; not sure how happy the skeleton
infra would be if you start unloading some parts on the side though.
If you have a valid usecase and want skeletons to support them,
definitely write to the list about them. There might be something
planned/implemented already.

Regarding deprecation: I think whatever is currently in the tree is
marked as 1.0, so all the deprecations have been already implemented.

> On Thu, Sep 8, 2022, 9:39 PM <sdf@google.com> wrote:
>>
>> On 09/08, Marcelo Juchem wrote:
>> > I'm not sure I can run all definite tests to know whether the program
>> > is loadable or not. I wouldn't even know what the tests should be in
>> > all cases.
>> > On the other hand, it's very practical for me to attempt attaching
>> > certain functions in order, until one of them works.
>> > Besides, that's not necessarily the only library functionality that
>> > could be built on top of this extra introspective power.
>>
>> > This is just one usage example, of course, but I'll try to illustrate
>> > what one possible application would look like:
>>
>> > ```
>> > size_t attach_with_fallback(bpf_object_skeleton *skeleton,
>> > std::initializer_list<size_t> probes) {
>> >    for (size_t i: probes) {
>> >      bpf_link *link =3D bpf_program__attach(*skeleton->progs[i].prog);
>> >      if (!libbpf_get_error(link)) {
>> >        return i;
>> >      }
>> >    }
>> >    return skeleton->prog_cnt;
>> > }
>>
>> > // ...
>>
>> > CHECK_ATTACHED(
>> >    attach_with_fallback(
>> >      obj->skeleton,
>> >      {
>> >        my_ebpf::prog_index::on_prepare_task_switch,
>> >        my_ebpf::prog_index::on_prepare_task_switch_isra_0,
>> >        my_ebpf::prog_index::on_finish_task_switch,
>> >        my_ebpf::prog_index::on_finish_task_switch_isra_0
>> >      }
>> >    )
>> > );
>> > CHECK_ATTACHED(
>> >    attach_with_fallback(
>> >      obj->skeleton,
>> >      {
>> >        my_ebpf::prog_index::on_tcp_recvmsg,
>> >        my_ebpf::prog_index::on_tcp_recvmsg_pre_5_19
>> >      }
>> >    )
>> > );
>> > ```
>>
>>
>> Thanks for the explanation, but I think I'm still confused :-)
>> You mention 'attach' and that the kernel will not let you attach,
>> but isn't 'attach' too late? Kernel should not let you load the program =
if
>> the
>> function signature doesn't match, so you need to have a load_with_fallba=
ck?
>>
>> But regardless, you should be able to achieve it without any new code it
>> seems:
>>
>> bool attach_with_fallback(std::initializer_list<struct bpf_program *>
>> progs) {
>>    for (auto p i: progs) {
>>      bpf_link *link =3D bpf_program__attach(p);
>>      if (!libbpf_get_error(link)) {
>>        return false;
>>      }
>>    }
>>    return true;
>> }
>>
>> CHECK_ATTACHED(
>>    attach_with_fallback(
>>      obj->skeleton,
>>      {
>>
>> bpf_object__find_program_by_name(obj->skeleton->obj, "on_tcp_recvmsg"),
>>
>> bpf_object__find_program_by_name(obj->skeleton->obj, "on_tcp_recvmsg_5_1=
9"),
>>      }
>>    )
>>
>> Would something like this work for you?
>>
>>
>>
>> > -mj
>>
>> > On Thu, Sep 8, 2022 at 5:03 PM <sdf@google.com> wrote:
>> > >
>> > > On 09/08, Marcelo Juchem wrote:
>> > > > The skeleton generated by `bpftool` makes it easy to attach and lo=
ad
>> > bpf
>> > > > objects as a whole. Some BPF programs are not directly portable ac=
ross
>> > > > kernel
>> > > > versions, though, and require some cherry-picking on which program=
s to
>> > > > load/attach. The skeleton makes this cherry-picking possible, but =
not
>> > > > entirely
>> > > > friendly in some cases.
>> > >
>> > > > For example, an useful feature is `attach_with_fallback` so that o=
ne
>> > > > program can be attempted, and fallback programs tried subsequently
>> > until
>> > > > one works (think `tcp_recvmsg` interface changing on kernel 5.19).
>> > >
>> > > > Being able to represent a set of probes programatically in a way t=
hat
>> > is
>> > > > both
>> > > > descriptive, compile-time validated, runtime efficient and custom
>> > library
>> > > > friendly is quite desirable for application developers. A very sim=
ple
>> > way
>> > > > to
>> > > > represent a set of probes is with an array of indices.
>> > >
>> > > > This patch creates a couple of enums under the `__cplusplus` secti=
on
>> > to
>> > > > represent the program and map indices inside the skeleton object, =
that
>> > > > can be
>> > > > used to refer to the proper program/map object.
>> > >
>> > > > This is the code generated for the `__cplusplus` section of
>> > > > `profiler.skel.h`:
>> > > > ```
>> > > >    enum map_idxs: size_t {
>> > > >      events =3D 0,
>> > > >      fentry_readings =3D 1,
>> > > >      accum_readings =3D 2,
>> > > >      counts =3D 3,
>> > > >      rodata =3D 4
>> > > >    };
>> > > >    enum prog_idxs: size_t {
>> > > >      fentry_XXX =3D 0,
>> > > >      fexit_XXX =3D 1
>> > > >    };
>> > > >    static inline struct profiler_bpf *open(const struct
>> > > > bpf_object_open_opts *opts =3D nullptr);
>> > > >    static inline struct profiler_bpf *open_and_load();
>> > > >    static inline int load(struct profiler_bpf *skel);
>> > > >    static inline int attach(struct profiler_bpf *skel);
>> > > >    static inline void detach(struct profiler_bpf *skel);
>> > > >    static inline void destroy(struct profiler_bpf *skel);
>> > > >    static inline const void *elf_bytes(size_t *sz);
>> > > > ```
>> > > > ---
>> > > >   src/gen.c | 32 ++++++++++++++++++++++++++++++++
>> > > >   1 file changed, 32 insertions(+)
>> > >
>> > > > diff --git a/src/gen.c b/src/gen.c
>> > > > index 7070dcf..7e28dc7 100644
>> > > > --- a/src/gen.c
>> > > > +++ b/src/gen.c
>> > > > @@ -1086,6 +1086,38 @@ static int do_skeleton(int argc, char **arg=
v)
>> > > >               \n\
>> > >
>> > >
>> > \n\
>> > > >               #ifdef
>> > __cplusplus                                          \n\
>> > > > +             "
>> > > > +     );
>> > > > +
>> > >
>> > > [..]
>> > >
>> > > > +     {
>> > > > +             size_t i =3D 0;
>> > > > +             printf("\tenum map_index: size_t {");
>> > > > +             bpf_object__for_each_map(map, obj) {
>> > > > +                     if (!get_map_ident(map, ident, sizeof(ident)=
))
>> > > > +                             continue;
>> > > > +                     if (i) {
>> > > > +                             printf(",");
>> > > > +                     }
>> > > > +                     printf("\n\t\t%s =3D %lu", ident, i);
>> > > > +                     ++i;
>> > > > +             }
>> > > > +             printf("\n\t};\n");
>> > > > +     }
>> > > > +     {
>> > > > +             size_t i =3D 0;
>> > > > +             printf("\tenum prog_index: size_t {");
>> > > > +             bpf_object__for_each_program(prog, obj) {
>> > > > +                     if (i) {
>> > > > +                             printf(",");
>> > > > +                     }
>> > > > +                     printf("\n\t\t%s =3D %lu",
>> > bpf_program__name(prog), i);
>> > > > +                     ++i;
>> > > > +             }
>> > > > +             printf("\n\t};\n");
>> > > > +     }
>> > >
>> > > I might be missing something, but what prevents you from calling the=
se
>> > > on the skeleton's bpf_object?
>> > >
>> > >    skel =3D xxx__open();
>> > >
>> > >    bpf_object__for_each_map(map, skel->obj) {
>> > >      // do whatever you want here to test whether it's loadable or n=
ot
>> > >    }
>> > >
>> > >    // same for bpf_object__for_each_program
>> > >
>> > >    xxx__load(skel);
>> > >
>> > > How do these new enums help?
