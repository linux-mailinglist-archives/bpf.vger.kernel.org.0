Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003BE5B3EAE
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 20:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiIISQP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 14:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIISQO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 14:16:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8644DF913B
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 11:16:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u22so2506970plq.12
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 11:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=z2IxCEYlBU5qJju1JO+IjK1J/oUEJnSPVJTnb/NlMJI=;
        b=KnxTbsjpdm76wcyQBFt+/+OyTtA83iafOdJ4GnYhVJRCk7bnY9N0Vp0PX3vIzbHFxo
         J6fa6cV8J1MMeizOAZL0Y+HWTQikEe7FoxnQBrZTrdV4QVSC6ltenArNoYq014p1Rovh
         2JSo3gKaUkKgERGqfyg9PRY2Id0DoSQMtFjtYohXqyRI8E1kyo1sN5MTLGifCxlJpmyC
         ehaoNcxfPsphjnV067mtPvo8nZQ4LkivelAijBEIsmIDsZueVVsZybGJ1Gw+CFfsgLPr
         hXC7Qi5ddm1tyFXUUBSxoWo+WyPkSYs6NkN8gamJylol1oGVkpcbLJVphmX7UXHpoeCF
         GpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=z2IxCEYlBU5qJju1JO+IjK1J/oUEJnSPVJTnb/NlMJI=;
        b=fATGV61zO3U4sDuiGChVhvdTS2a8aGBG2ZWmovZhkgscYAEjJ6L5daEGYpC+W1bbCv
         CeGtuAR0GHqmAJV0TYEAj65rWGKuX5nthhFeJqBi8BitQwbSNgKczQWP4tLxXZTtHhiW
         uoTmkCwCTY3OHvAOJJ3aGETdjN0iTbSmNLPcEGlXWJcQJi0yVkD/RBQr8A8jc2TvjwDY
         3IPBa2PRMvNF6bUZqAp2VadNLdNuhuPBTLDkLHt2AkbRpW4FVBxSyA5XXjaPLb9WUCVz
         aO1GmNrT1KLCR6ejv+HMCA1PDC6GyGjvkjX4/8IAjPL5rPgw9oNQWUD+PsIgzqw4ICWB
         3CxA==
X-Gm-Message-State: ACgBeo0Pl7lIZuwtOqIZ5OpsEPXMQFuIoV77529ooGGFkCgIupqaLDrl
        n2Fc5AD8QwD0P1mxK5hz0VyW9OaYXu5e7fV8938Slg==
X-Google-Smtp-Source: AA6agR45mzxk8r9SIMmL9ASQjoo4jo3A/0C36tFlSg1uwyjFbbYt4lzcpgSHcfCAIMcsE+kIz4YL/UaebQgq8HI9Z+k=
X-Received: by 2002:a17:902:968d:b0:176:93d6:317c with SMTP id
 n13-20020a170902968d00b0017693d6317cmr14636179plp.148.1662747371672; Fri, 09
 Sep 2022 11:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220908183952.3438815-1-mj@hunetr.com> <YxpmmepVMXXcaNfh@google.com>
 <CAK0nC2VpY-ag_OJr+mF=WGGAxUEwE6bDeB5mMmMJoSVp4i4iAQ@mail.gmail.com>
 <YxqnWuH8LRBDlFRV@google.com> <CAK0nC2VSBn3onXW2LfHdH4c+T6qCfcWHPE99QAV5pjqFj_pMUg@mail.gmail.com>
 <CAKH8qBs-V-YB+hjDgARVcHO_HTz0__GFS_OU1vs_5e07zd3V8Q@mail.gmail.com> <CAK0nC2WY6wskdpHGXL74DJ2u1X5i-E4vt4h8PQx9PdmHsfSv4g@mail.gmail.com>
In-Reply-To: <CAK0nC2WY6wskdpHGXL74DJ2u1X5i-E4vt4h8PQx9PdmHsfSv4g@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 9 Sep 2022 11:16:00 -0700
Message-ID: <CAKH8qBv2UZRgsD7J8_7ExOV-saEUoovvXBdv9GC-AaB33XLGsg@mail.gmail.com>
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

On Fri, Sep 9, 2022 at 9:40 AM Marcelo Juchem <juchem@gmail.com> wrote:
>
> Thank you, that has been a lot of help already.
>
> As for the unions, I'm personally very wary of making assumptions
> about the memory layout of unions. It may be just FUD, but I tend to
> avoid it. I chose the enum route basically because it doesn't mess
> with existing code whatsoever; and because array indexing is clean,
> portable and just works. I also chose to do it only for C++ because I
> didn't want to clutter the global namespace with yet more symbols (in
> hindsight, it might have been a better idea to make it an `enum
> class`). That said, I'm not obsessed about landing the patch. If
> there's no net benefit overall for the community, let's just drop it.

I think these memory layout assumptions might be fine if they are
baked into the skeleton generation code itself.
Otherwise yes, I won't be comfortable depending on the layout.

> With regards to splitting ebpf code into separate object files: is it
> possible to define a bpf map in one obj file and use it from another?
> I assume the answer is no, but felt like asking regardless. This would
> greatly simplify things on my end. Shared maps is the only reason I
> have mostly everything in the same obj.

It's possible, take a look at bpf_map__reuse_fd. You still have to
"define" it in both progs, but during loading, you can ask one prog to
reuse some other map instead of creating another copy.

But I was suggesting:

struct {} mymap SEC(".maps");
#ifdef OLD_RECVMSG
SEC("fentry/tcp_recvmsg") int tcp_recvmsg_old(...) {}
#endif
#ifdef NEW_RECVMSG
SEC("fentry/tcp_recvmsg") int tcp_recvmsg_new(...) {}
#endif

Then you do:
clang -target bpf -DNEW_RECVMSG myprog.c -o my_prog_new.o
clang -target bpf -DOLD_RECVMSG myprog.c -o my_prog_old.o

Then treat them separately with separate skeletons; try to load
my_prog_new.o first and fallback to my_prog_old.o.
This might work for some simple cases where you don't have a lot of
combinations of options.

> -mj
>
> On Fri, Sep 9, 2022 at 11:25 AM Stanislav Fomichev <sdf@google.com> wrote=
:
> >
> > On Thu, Sep 8, 2022 at 8:43 PM Marcelo Juchem <juchem@gmail.com> wrote:
> > >
> > > Indeed, that works for this case. And yes, I do need something like l=
oad-with-fallbak.
> > >
> > > Let me pick your brain on the API, if you don't mind. Perhaps I can d=
o all I need with the current API:
> > >
> > > - I read the 1.0 roadmap document and unless I misunderstood somethin=
g, it seems that there are problems with loading individual programs and on=
e should lean towards loading the whole object at once. Is that the case? I=
'm mostly concerned with a good way to implement load_with_fallback.
> >
> > I'm not 100% sure about the roadmap, a haven't looked at it for a
> > while, but from the latest movement on libbpf:
> >
> > You can control autoloading with either bpf_program__set_autoload or
> > doing SEC("?fentry/tcp_recvmsg").
> >
> > So you can probably do the following (which won't load those progs by d=
efault):
> >
> > SEC("?fentry/tcp_recvmsg") int tcp_recvmsg_old(...) {}
> > SEC("?fentry/tcp_recvmsg") int tcp_recvmsg_new(...) {}
> >
> > Then open the obj, enable autoload for tcp_recvmsg_new, and try to
> > load. If it fails, disable autoload for tcp_recvmsg_new, and retry
> > with autoload=3Dtrue for tcp_recvmsg_old.
> >
> > But if you can do compilation tricks to have two separate obj files
> > with different versions that you can try to load in order, that might
> > be easier. I guess it depends on what you're trying to do. Here at G
> > we use both tricks for different programs, some have v1/v2/vX
> > suffixes, for some we selectively enable/disable parts of the obj
> > file.
> >
> > > - from bpf_prog_skeleton I have access to both the bpf_program and th=
e bpf_link. Is there a way to get the bpf_link if all I have is a bpf_progr=
am * (assuming it's already attached)? Using the enums as the selector I ca=
n definitely do that (gives me direct access to bpf_prog_skeleton);
> >
> > Not that I see. I feel like with the way it's currently generated, the
> > only clean way is to std::map<bpf_program *, bpf_link *> somewhere.
> > (casting progs to struct bpf_program * and treating them as an array
> > might be an option, but it depends on the skeleton layout).
> > But that might be a valid use-case for your enums here. Or, instead of
> > enums, maybe generate the following skeleton?
> >
> > union {
> >   struct {
> >     struct bpf_program *a;
> >     struct bpf_program *b;
> >   } progs;
> >   struct bpf_program *prog_list[2];
> > }
> > union {
> >   struct {
> >     struct bpf_link *a;
> >     struct bpf_link *b;
> >   } links;
> >   struct bpf_link *link_list[2];
> > }
> >
> > That should maintain the mapping? Andrii (CC'ed) might give you better
> > suggestions.
> >
> > > - can I selectively detach and unload some programs, but not others, =
in a reliable and safe manner? I ask mostly because of the 1.0 deprecation =
that I heard is going on, and I'm unsure which parts of the API are stable =
and which are going away. Right now I detach and destroy everything using t=
he high level helpers from the generated skeleton, but I have some legitima=
te need to load a set of programs then unload a subset of them after some i=
nitial discovery is performed.
> >
> > You can definitely selectively detach/unload; maybe not through
> > skeleton, but definitely via libbpf; not sure how happy the skeleton
> > infra would be if you start unloading some parts on the side though.
> > If you have a valid usecase and want skeletons to support them,
> > definitely write to the list about them. There might be something
> > planned/implemented already.
> >
> > Regarding deprecation: I think whatever is currently in the tree is
> > marked as 1.0, so all the deprecations have been already implemented.
> >
> > > On Thu, Sep 8, 2022, 9:39 PM <sdf@google.com> wrote:
> > >>
> > >> On 09/08, Marcelo Juchem wrote:
> > >> > I'm not sure I can run all definite tests to know whether the prog=
ram
> > >> > is loadable or not. I wouldn't even know what the tests should be =
in
> > >> > all cases.
> > >> > On the other hand, it's very practical for me to attempt attaching
> > >> > certain functions in order, until one of them works.
> > >> > Besides, that's not necessarily the only library functionality tha=
t
> > >> > could be built on top of this extra introspective power.
> > >>
> > >> > This is just one usage example, of course, but I'll try to illustr=
ate
> > >> > what one possible application would look like:
> > >>
> > >> > ```
> > >> > size_t attach_with_fallback(bpf_object_skeleton *skeleton,
> > >> > std::initializer_list<size_t> probes) {
> > >> >    for (size_t i: probes) {
> > >> >      bpf_link *link =3D bpf_program__attach(*skeleton->progs[i].pr=
og);
> > >> >      if (!libbpf_get_error(link)) {
> > >> >        return i;
> > >> >      }
> > >> >    }
> > >> >    return skeleton->prog_cnt;
> > >> > }
> > >>
> > >> > // ...
> > >>
> > >> > CHECK_ATTACHED(
> > >> >    attach_with_fallback(
> > >> >      obj->skeleton,
> > >> >      {
> > >> >        my_ebpf::prog_index::on_prepare_task_switch,
> > >> >        my_ebpf::prog_index::on_prepare_task_switch_isra_0,
> > >> >        my_ebpf::prog_index::on_finish_task_switch,
> > >> >        my_ebpf::prog_index::on_finish_task_switch_isra_0
> > >> >      }
> > >> >    )
> > >> > );
> > >> > CHECK_ATTACHED(
> > >> >    attach_with_fallback(
> > >> >      obj->skeleton,
> > >> >      {
> > >> >        my_ebpf::prog_index::on_tcp_recvmsg,
> > >> >        my_ebpf::prog_index::on_tcp_recvmsg_pre_5_19
> > >> >      }
> > >> >    )
> > >> > );
> > >> > ```
> > >>
> > >>
> > >> Thanks for the explanation, but I think I'm still confused :-)
> > >> You mention 'attach' and that the kernel will not let you attach,
> > >> but isn't 'attach' too late? Kernel should not let you load the prog=
ram if
> > >> the
> > >> function signature doesn't match, so you need to have a load_with_fa=
llback?
> > >>
> > >> But regardless, you should be able to achieve it without any new cod=
e it
> > >> seems:
> > >>
> > >> bool attach_with_fallback(std::initializer_list<struct bpf_program *=
>
> > >> progs) {
> > >>    for (auto p i: progs) {
> > >>      bpf_link *link =3D bpf_program__attach(p);
> > >>      if (!libbpf_get_error(link)) {
> > >>        return false;
> > >>      }
> > >>    }
> > >>    return true;
> > >> }
> > >>
> > >> CHECK_ATTACHED(
> > >>    attach_with_fallback(
> > >>      obj->skeleton,
> > >>      {
> > >>
> > >> bpf_object__find_program_by_name(obj->skeleton->obj, "on_tcp_recvmsg=
"),
> > >>
> > >> bpf_object__find_program_by_name(obj->skeleton->obj, "on_tcp_recvmsg=
_5_19"),
> > >>      }
> > >>    )
> > >>
> > >> Would something like this work for you?
> > >>
> > >>
> > >>
> > >> > -mj
> > >>
> > >> > On Thu, Sep 8, 2022 at 5:03 PM <sdf@google.com> wrote:
> > >> > >
> > >> > > On 09/08, Marcelo Juchem wrote:
> > >> > > > The skeleton generated by `bpftool` makes it easy to attach an=
d load
> > >> > bpf
> > >> > > > objects as a whole. Some BPF programs are not directly portabl=
e across
> > >> > > > kernel
> > >> > > > versions, though, and require some cherry-picking on which pro=
grams to
> > >> > > > load/attach. The skeleton makes this cherry-picking possible, =
but not
> > >> > > > entirely
> > >> > > > friendly in some cases.
> > >> > >
> > >> > > > For example, an useful feature is `attach_with_fallback` so th=
at one
> > >> > > > program can be attempted, and fallback programs tried subseque=
ntly
> > >> > until
> > >> > > > one works (think `tcp_recvmsg` interface changing on kernel 5.=
19).
> > >> > >
> > >> > > > Being able to represent a set of probes programatically in a w=
ay that
> > >> > is
> > >> > > > both
> > >> > > > descriptive, compile-time validated, runtime efficient and cus=
tom
> > >> > library
> > >> > > > friendly is quite desirable for application developers. A very=
 simple
> > >> > way
> > >> > > > to
> > >> > > > represent a set of probes is with an array of indices.
> > >> > >
> > >> > > > This patch creates a couple of enums under the `__cplusplus` s=
ection
> > >> > to
> > >> > > > represent the program and map indices inside the skeleton obje=
ct, that
> > >> > > > can be
> > >> > > > used to refer to the proper program/map object.
> > >> > >
> > >> > > > This is the code generated for the `__cplusplus` section of
> > >> > > > `profiler.skel.h`:
> > >> > > > ```
> > >> > > >    enum map_idxs: size_t {
> > >> > > >      events =3D 0,
> > >> > > >      fentry_readings =3D 1,
> > >> > > >      accum_readings =3D 2,
> > >> > > >      counts =3D 3,
> > >> > > >      rodata =3D 4
> > >> > > >    };
> > >> > > >    enum prog_idxs: size_t {
> > >> > > >      fentry_XXX =3D 0,
> > >> > > >      fexit_XXX =3D 1
> > >> > > >    };
> > >> > > >    static inline struct profiler_bpf *open(const struct
> > >> > > > bpf_object_open_opts *opts =3D nullptr);
> > >> > > >    static inline struct profiler_bpf *open_and_load();
> > >> > > >    static inline int load(struct profiler_bpf *skel);
> > >> > > >    static inline int attach(struct profiler_bpf *skel);
> > >> > > >    static inline void detach(struct profiler_bpf *skel);
> > >> > > >    static inline void destroy(struct profiler_bpf *skel);
> > >> > > >    static inline const void *elf_bytes(size_t *sz);
> > >> > > > ```
> > >> > > > ---
> > >> > > >   src/gen.c | 32 ++++++++++++++++++++++++++++++++
> > >> > > >   1 file changed, 32 insertions(+)
> > >> > >
> > >> > > > diff --git a/src/gen.c b/src/gen.c
> > >> > > > index 7070dcf..7e28dc7 100644
> > >> > > > --- a/src/gen.c
> > >> > > > +++ b/src/gen.c
> > >> > > > @@ -1086,6 +1086,38 @@ static int do_skeleton(int argc, char *=
*argv)
> > >> > > >               \n\
> > >> > >
> > >> > >
> > >> > \n\
> > >> > > >               #ifdef
> > >> > __cplusplus                                          \n\
> > >> > > > +             "
> > >> > > > +     );
> > >> > > > +
> > >> > >
> > >> > > [..]
> > >> > >
> > >> > > > +     {
> > >> > > > +             size_t i =3D 0;
> > >> > > > +             printf("\tenum map_index: size_t {");
> > >> > > > +             bpf_object__for_each_map(map, obj) {
> > >> > > > +                     if (!get_map_ident(map, ident, sizeof(id=
ent)))
> > >> > > > +                             continue;
> > >> > > > +                     if (i) {
> > >> > > > +                             printf(",");
> > >> > > > +                     }
> > >> > > > +                     printf("\n\t\t%s =3D %lu", ident, i);
> > >> > > > +                     ++i;
> > >> > > > +             }
> > >> > > > +             printf("\n\t};\n");
> > >> > > > +     }
> > >> > > > +     {
> > >> > > > +             size_t i =3D 0;
> > >> > > > +             printf("\tenum prog_index: size_t {");
> > >> > > > +             bpf_object__for_each_program(prog, obj) {
> > >> > > > +                     if (i) {
> > >> > > > +                             printf(",");
> > >> > > > +                     }
> > >> > > > +                     printf("\n\t\t%s =3D %lu",
> > >> > bpf_program__name(prog), i);
> > >> > > > +                     ++i;
> > >> > > > +             }
> > >> > > > +             printf("\n\t};\n");
> > >> > > > +     }
> > >> > >
> > >> > > I might be missing something, but what prevents you from calling=
 these
> > >> > > on the skeleton's bpf_object?
> > >> > >
> > >> > >    skel =3D xxx__open();
> > >> > >
> > >> > >    bpf_object__for_each_map(map, skel->obj) {
> > >> > >      // do whatever you want here to test whether it's loadable =
or not
> > >> > >    }
> > >> > >
> > >> > >    // same for bpf_object__for_each_program
> > >> > >
> > >> > >    xxx__load(skel);
> > >> > >
> > >> > > How do these new enums help?
