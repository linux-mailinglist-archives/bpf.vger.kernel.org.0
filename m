Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA685B3D32
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 18:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIIQlA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 12:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiIIQkt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 12:40:49 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5DB77562
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 09:40:47 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id jm11so2282885plb.13
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=c36ZTzKnTSiU2kSksy/knn5XJjTmlRhpIIqlPY0S5X8=;
        b=QjtCp9SnaUX9tNJmS02ZdlFGLcLrLj3LMy3RkFyKyh3lAJblaUh5nrQIymOVBkqjYM
         VK8EwLV/Y+zfplMwr2iUoFcT4mg/+uhMTn4Ysi5oAZ8j+kRO7eDw5Wajoqkt6VQe3ZHP
         Aq/XawZJu+hbiwrV8hGqy3K6gl4hz9b0zs9ZHLCf0P5vxkvN6bTpH8ZO/s2G9n0aSdhL
         XqUbSnmYOviFOktT0oK1+ahpKqMBF0Y9CwkaVN58rxLvTCD5j0MOEy4HCsPg4Eg1Y5pS
         GerShkV8aY+z8T0wICdTkkHIePm0oSv2xgZgUycuXvA8AHnHcFd0XbpkO2ZsiL+bcV71
         txjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=c36ZTzKnTSiU2kSksy/knn5XJjTmlRhpIIqlPY0S5X8=;
        b=WyYGjnJrJZWBIZcM0Gs8qGSJsQGyaTPpBvRx+0azW1ZPGQxNke/CchXJn3DdvSm2If
         x59bMzy2kg99VevU8Usm5oTkCkwu8quMBzDqIDCeX3SDPg5KHFMd0QBUs58gSGBvSaPK
         epotQsWFVG2anvYQwbvPpL7tm9hivjkIUSvS3ylXqWG/7bKzbo1kLkwBFYGKVOZbSJaT
         /Raed546+hud8MQdLcRgikJj8DPjClDqKu2r1gGvis8oJdl3iOFe3YHeR0e8+egnIk4Z
         923qRQ1qd9RGZfTtkswRWjZmxgGpChAUW9b8O/DAFCBsCjyCjy06i0tCJhPkNKq3TFab
         PLAg==
X-Gm-Message-State: ACgBeo1DhkMwUDSc14KC5gh3rv/6rU6yyBy2jTBWM15g1AmquGV3hnho
        fGNRpLniF8Zw2pSaOMKNjRz0xpI1tvw1ajwkaOE=
X-Google-Smtp-Source: AA6agR6YS8GQN+X52ev7N9Edi6L4Hjcxl2HvdzfBWlg1mA8nppnTHWOdZRMitJltrlnhfr9awZ6PwaQ4NhHph6d8SV0=
X-Received: by 2002:a17:902:8d8c:b0:172:e237:9a4e with SMTP id
 v12-20020a1709028d8c00b00172e2379a4emr14857576plo.158.1662741647075; Fri, 09
 Sep 2022 09:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220908183952.3438815-1-mj@hunetr.com> <YxpmmepVMXXcaNfh@google.com>
 <CAK0nC2VpY-ag_OJr+mF=WGGAxUEwE6bDeB5mMmMJoSVp4i4iAQ@mail.gmail.com>
 <YxqnWuH8LRBDlFRV@google.com> <CAK0nC2VSBn3onXW2LfHdH4c+T6qCfcWHPE99QAV5pjqFj_pMUg@mail.gmail.com>
 <CAKH8qBs-V-YB+hjDgARVcHO_HTz0__GFS_OU1vs_5e07zd3V8Q@mail.gmail.com>
In-Reply-To: <CAKH8qBs-V-YB+hjDgARVcHO_HTz0__GFS_OU1vs_5e07zd3V8Q@mail.gmail.com>
From:   Marcelo Juchem <juchem@gmail.com>
Date:   Fri, 9 Sep 2022 11:40:10 -0500
Message-ID: <CAK0nC2WY6wskdpHGXL74DJ2u1X5i-E4vt4h8PQx9PdmHsfSv4g@mail.gmail.com>
Subject: Re: [PATCH] bpftool: output map/prog indices on `gen skeleton`
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, Marcelo Juchem <mj@hunetr.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thank you, that has been a lot of help already.

As for the unions, I'm personally very wary of making assumptions
about the memory layout of unions. It may be just FUD, but I tend to
avoid it. I chose the enum route basically because it doesn't mess
with existing code whatsoever; and because array indexing is clean,
portable and just works. I also chose to do it only for C++ because I
didn't want to clutter the global namespace with yet more symbols (in
hindsight, it might have been a better idea to make it an `enum
class`). That said, I'm not obsessed about landing the patch. If
there's no net benefit overall for the community, let's just drop it.

With regards to splitting ebpf code into separate object files: is it
possible to define a bpf map in one obj file and use it from another?
I assume the answer is no, but felt like asking regardless. This would
greatly simplify things on my end. Shared maps is the only reason I
have mostly everything in the same obj.

-mj

On Fri, Sep 9, 2022 at 11:25 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Thu, Sep 8, 2022 at 8:43 PM Marcelo Juchem <juchem@gmail.com> wrote:
> >
> > Indeed, that works for this case. And yes, I do need something like loa=
d-with-fallbak.
> >
> > Let me pick your brain on the API, if you don't mind. Perhaps I can do =
all I need with the current API:
> >
> > - I read the 1.0 roadmap document and unless I misunderstood something,=
 it seems that there are problems with loading individual programs and one =
should lean towards loading the whole object at once. Is that the case? I'm=
 mostly concerned with a good way to implement load_with_fallback.
>
> I'm not 100% sure about the roadmap, a haven't looked at it for a
> while, but from the latest movement on libbpf:
>
> You can control autoloading with either bpf_program__set_autoload or
> doing SEC("?fentry/tcp_recvmsg").
>
> So you can probably do the following (which won't load those progs by def=
ault):
>
> SEC("?fentry/tcp_recvmsg") int tcp_recvmsg_old(...) {}
> SEC("?fentry/tcp_recvmsg") int tcp_recvmsg_new(...) {}
>
> Then open the obj, enable autoload for tcp_recvmsg_new, and try to
> load. If it fails, disable autoload for tcp_recvmsg_new, and retry
> with autoload=3Dtrue for tcp_recvmsg_old.
>
> But if you can do compilation tricks to have two separate obj files
> with different versions that you can try to load in order, that might
> be easier. I guess it depends on what you're trying to do. Here at G
> we use both tricks for different programs, some have v1/v2/vX
> suffixes, for some we selectively enable/disable parts of the obj
> file.
>
> > - from bpf_prog_skeleton I have access to both the bpf_program and the =
bpf_link. Is there a way to get the bpf_link if all I have is a bpf_program=
 * (assuming it's already attached)? Using the enums as the selector I can =
definitely do that (gives me direct access to bpf_prog_skeleton);
>
> Not that I see. I feel like with the way it's currently generated, the
> only clean way is to std::map<bpf_program *, bpf_link *> somewhere.
> (casting progs to struct bpf_program * and treating them as an array
> might be an option, but it depends on the skeleton layout).
> But that might be a valid use-case for your enums here. Or, instead of
> enums, maybe generate the following skeleton?
>
> union {
>   struct {
>     struct bpf_program *a;
>     struct bpf_program *b;
>   } progs;
>   struct bpf_program *prog_list[2];
> }
> union {
>   struct {
>     struct bpf_link *a;
>     struct bpf_link *b;
>   } links;
>   struct bpf_link *link_list[2];
> }
>
> That should maintain the mapping? Andrii (CC'ed) might give you better
> suggestions.
>
> > - can I selectively detach and unload some programs, but not others, in=
 a reliable and safe manner? I ask mostly because of the 1.0 deprecation th=
at I heard is going on, and I'm unsure which parts of the API are stable an=
d which are going away. Right now I detach and destroy everything using the=
 high level helpers from the generated skeleton, but I have some legitimate=
 need to load a set of programs then unload a subset of them after some ini=
tial discovery is performed.
>
> You can definitely selectively detach/unload; maybe not through
> skeleton, but definitely via libbpf; not sure how happy the skeleton
> infra would be if you start unloading some parts on the side though.
> If you have a valid usecase and want skeletons to support them,
> definitely write to the list about them. There might be something
> planned/implemented already.
>
> Regarding deprecation: I think whatever is currently in the tree is
> marked as 1.0, so all the deprecations have been already implemented.
>
> > On Thu, Sep 8, 2022, 9:39 PM <sdf@google.com> wrote:
> >>
> >> On 09/08, Marcelo Juchem wrote:
> >> > I'm not sure I can run all definite tests to know whether the progra=
m
> >> > is loadable or not. I wouldn't even know what the tests should be in
> >> > all cases.
> >> > On the other hand, it's very practical for me to attempt attaching
> >> > certain functions in order, until one of them works.
> >> > Besides, that's not necessarily the only library functionality that
> >> > could be built on top of this extra introspective power.
> >>
> >> > This is just one usage example, of course, but I'll try to illustrat=
e
> >> > what one possible application would look like:
> >>
> >> > ```
> >> > size_t attach_with_fallback(bpf_object_skeleton *skeleton,
> >> > std::initializer_list<size_t> probes) {
> >> >    for (size_t i: probes) {
> >> >      bpf_link *link =3D bpf_program__attach(*skeleton->progs[i].prog=
);
> >> >      if (!libbpf_get_error(link)) {
> >> >        return i;
> >> >      }
> >> >    }
> >> >    return skeleton->prog_cnt;
> >> > }
> >>
> >> > // ...
> >>
> >> > CHECK_ATTACHED(
> >> >    attach_with_fallback(
> >> >      obj->skeleton,
> >> >      {
> >> >        my_ebpf::prog_index::on_prepare_task_switch,
> >> >        my_ebpf::prog_index::on_prepare_task_switch_isra_0,
> >> >        my_ebpf::prog_index::on_finish_task_switch,
> >> >        my_ebpf::prog_index::on_finish_task_switch_isra_0
> >> >      }
> >> >    )
> >> > );
> >> > CHECK_ATTACHED(
> >> >    attach_with_fallback(
> >> >      obj->skeleton,
> >> >      {
> >> >        my_ebpf::prog_index::on_tcp_recvmsg,
> >> >        my_ebpf::prog_index::on_tcp_recvmsg_pre_5_19
> >> >      }
> >> >    )
> >> > );
> >> > ```
> >>
> >>
> >> Thanks for the explanation, but I think I'm still confused :-)
> >> You mention 'attach' and that the kernel will not let you attach,
> >> but isn't 'attach' too late? Kernel should not let you load the progra=
m if
> >> the
> >> function signature doesn't match, so you need to have a load_with_fall=
back?
> >>
> >> But regardless, you should be able to achieve it without any new code =
it
> >> seems:
> >>
> >> bool attach_with_fallback(std::initializer_list<struct bpf_program *>
> >> progs) {
> >>    for (auto p i: progs) {
> >>      bpf_link *link =3D bpf_program__attach(p);
> >>      if (!libbpf_get_error(link)) {
> >>        return false;
> >>      }
> >>    }
> >>    return true;
> >> }
> >>
> >> CHECK_ATTACHED(
> >>    attach_with_fallback(
> >>      obj->skeleton,
> >>      {
> >>
> >> bpf_object__find_program_by_name(obj->skeleton->obj, "on_tcp_recvmsg")=
,
> >>
> >> bpf_object__find_program_by_name(obj->skeleton->obj, "on_tcp_recvmsg_5=
_19"),
> >>      }
> >>    )
> >>
> >> Would something like this work for you?
> >>
> >>
> >>
> >> > -mj
> >>
> >> > On Thu, Sep 8, 2022 at 5:03 PM <sdf@google.com> wrote:
> >> > >
> >> > > On 09/08, Marcelo Juchem wrote:
> >> > > > The skeleton generated by `bpftool` makes it easy to attach and =
load
> >> > bpf
> >> > > > objects as a whole. Some BPF programs are not directly portable =
across
> >> > > > kernel
> >> > > > versions, though, and require some cherry-picking on which progr=
ams to
> >> > > > load/attach. The skeleton makes this cherry-picking possible, bu=
t not
> >> > > > entirely
> >> > > > friendly in some cases.
> >> > >
> >> > > > For example, an useful feature is `attach_with_fallback` so that=
 one
> >> > > > program can be attempted, and fallback programs tried subsequent=
ly
> >> > until
> >> > > > one works (think `tcp_recvmsg` interface changing on kernel 5.19=
).
> >> > >
> >> > > > Being able to represent a set of probes programatically in a way=
 that
> >> > is
> >> > > > both
> >> > > > descriptive, compile-time validated, runtime efficient and custo=
m
> >> > library
> >> > > > friendly is quite desirable for application developers. A very s=
imple
> >> > way
> >> > > > to
> >> > > > represent a set of probes is with an array of indices.
> >> > >
> >> > > > This patch creates a couple of enums under the `__cplusplus` sec=
tion
> >> > to
> >> > > > represent the program and map indices inside the skeleton object=
, that
> >> > > > can be
> >> > > > used to refer to the proper program/map object.
> >> > >
> >> > > > This is the code generated for the `__cplusplus` section of
> >> > > > `profiler.skel.h`:
> >> > > > ```
> >> > > >    enum map_idxs: size_t {
> >> > > >      events =3D 0,
> >> > > >      fentry_readings =3D 1,
> >> > > >      accum_readings =3D 2,
> >> > > >      counts =3D 3,
> >> > > >      rodata =3D 4
> >> > > >    };
> >> > > >    enum prog_idxs: size_t {
> >> > > >      fentry_XXX =3D 0,
> >> > > >      fexit_XXX =3D 1
> >> > > >    };
> >> > > >    static inline struct profiler_bpf *open(const struct
> >> > > > bpf_object_open_opts *opts =3D nullptr);
> >> > > >    static inline struct profiler_bpf *open_and_load();
> >> > > >    static inline int load(struct profiler_bpf *skel);
> >> > > >    static inline int attach(struct profiler_bpf *skel);
> >> > > >    static inline void detach(struct profiler_bpf *skel);
> >> > > >    static inline void destroy(struct profiler_bpf *skel);
> >> > > >    static inline const void *elf_bytes(size_t *sz);
> >> > > > ```
> >> > > > ---
> >> > > >   src/gen.c | 32 ++++++++++++++++++++++++++++++++
> >> > > >   1 file changed, 32 insertions(+)
> >> > >
> >> > > > diff --git a/src/gen.c b/src/gen.c
> >> > > > index 7070dcf..7e28dc7 100644
> >> > > > --- a/src/gen.c
> >> > > > +++ b/src/gen.c
> >> > > > @@ -1086,6 +1086,38 @@ static int do_skeleton(int argc, char **a=
rgv)
> >> > > >               \n\
> >> > >
> >> > >
> >> > \n\
> >> > > >               #ifdef
> >> > __cplusplus                                          \n\
> >> > > > +             "
> >> > > > +     );
> >> > > > +
> >> > >
> >> > > [..]
> >> > >
> >> > > > +     {
> >> > > > +             size_t i =3D 0;
> >> > > > +             printf("\tenum map_index: size_t {");
> >> > > > +             bpf_object__for_each_map(map, obj) {
> >> > > > +                     if (!get_map_ident(map, ident, sizeof(iden=
t)))
> >> > > > +                             continue;
> >> > > > +                     if (i) {
> >> > > > +                             printf(",");
> >> > > > +                     }
> >> > > > +                     printf("\n\t\t%s =3D %lu", ident, i);
> >> > > > +                     ++i;
> >> > > > +             }
> >> > > > +             printf("\n\t};\n");
> >> > > > +     }
> >> > > > +     {
> >> > > > +             size_t i =3D 0;
> >> > > > +             printf("\tenum prog_index: size_t {");
> >> > > > +             bpf_object__for_each_program(prog, obj) {
> >> > > > +                     if (i) {
> >> > > > +                             printf(",");
> >> > > > +                     }
> >> > > > +                     printf("\n\t\t%s =3D %lu",
> >> > bpf_program__name(prog), i);
> >> > > > +                     ++i;
> >> > > > +             }
> >> > > > +             printf("\n\t};\n");
> >> > > > +     }
> >> > >
> >> > > I might be missing something, but what prevents you from calling t=
hese
> >> > > on the skeleton's bpf_object?
> >> > >
> >> > >    skel =3D xxx__open();
> >> > >
> >> > >    bpf_object__for_each_map(map, skel->obj) {
> >> > >      // do whatever you want here to test whether it's loadable or=
 not
> >> > >    }
> >> > >
> >> > >    // same for bpf_object__for_each_program
> >> > >
> >> > >    xxx__load(skel);
> >> > >
> >> > > How do these new enums help?
