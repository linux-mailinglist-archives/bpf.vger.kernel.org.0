Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35BC4DA208
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 19:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbiCOSIm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 14:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbiCOSIl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 14:08:41 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AB45938F
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:07:29 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id o12so19751ilg.5
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KeEHEC1qP8Iz8+P6ol2ROtn1B8lWk3ORpKYLoYDhx0=;
        b=pz6DBT53ZRQe/LrSe7LHnPHUh3P74p/nGhCyPttdNQr4FkyFJCUBwvHCbjx/3Vm9jw
         /R/FxvCw6DJRHII+fSZ5Lahl+ppVPJcKgJwpE6ImAsqK41t3iaitX8Ujk7Yc9EM73DRc
         5rmr1wYzoP87OCU2Vq3BxZEoRs9XqoN9XihaUnQzPSxFS4AYdis7ZwNCJ4sSGQ4CLZXl
         F0BpFsVcT/Qfjc4205I43eLnFeZU/9W/gave85Fdk7Wzzmc2gNoUDrG1T1wTQLgT+rsC
         UxZ22TdE3+bTYX+DUDn6dr2RJJL+xx1vBhGUAajX1WwGAvgeIz2YsnWy7OaSG+J+E2eO
         pcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KeEHEC1qP8Iz8+P6ol2ROtn1B8lWk3ORpKYLoYDhx0=;
        b=D1qcoD9t++aO9UaOvVQ+NbWJovgXNFOAmPBLtVrG1qVvBK2jU0TKBgwqa+xxNzQNJL
         RL+TcpxMQVLXhrCZt1l/Eq0TqE4Olgad5CucxI9a5TDTXq7GkAthzmhX6V80Qfz5rybS
         aRmYtslfENn/KmRCPzazHXIn+93hD5HgEH8derGwQuZuZq3w2axNT/jRgG08JBgAfpIw
         8phOmyZyl3ZSZjyyW727Qqxnw/YzrctdfYlo0Cp3b+vIdXPDxzSpK39mc2Lt1s/Sv4vI
         HFY2MpdaBlIDqEDx9rdlx/KjlJZ82JnTFTzIMmqFYABmEhcCyu8a2wZMthYZiAcrFcTo
         ChJg==
X-Gm-Message-State: AOAM531qN2aP9hRb8wFO6/tYyAkJkdxLxJ1ZMzvFlTYXcWrSZWGrRPjx
        jAPpMUn5DGCWaTJX3hl7znHQJkMwOUV+8UozfWdeI5gbuSY=
X-Google-Smtp-Source: ABdhPJy48ATANinVQc4rHXyw0I+ejFkFY5v1D/PVKSK089SuRDlpJkt7m9evdEMiIfff4BpiJPpgUe9FTUCltzTPjZg=
X-Received: by 2002:a92:d241:0:b0:2c6:d22:27cf with SMTP id
 v1-20020a92d241000000b002c60d2227cfmr22425999ilg.98.1647367648453; Tue, 15
 Mar 2022 11:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646957399.git.delyank@fb.com> <d3ee2b3bb282e8aa0e6ab01ca4be522004a7cba0.1646957399.git.delyank@fb.com>
 <CAEf4BzaeycEUjZVCd+7sxFaQWfbqhmsMd_G_bydS15+45LcDvA@mail.gmail.com> <e3e84d87c2a0c13ae9f20e44493c1578e06b6618.camel@fb.com>
In-Reply-To: <e3e84d87c2a0c13ae9f20e44493c1578e06b6618.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Mar 2022 11:07:17 -0700
Message-ID: <CAEf4BzadGd9E+1ZmANunL7LWAMK6pZxcap+Po6x+cAKjhAMOkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpftool: add support for subskeletons
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 14, 2022 at 4:18 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Thanks, Andrii! The nits/refactors are straightforward but have some questions
> below:
>
> On Fri, 2022-03-11 at 15:27 -0800, Andrii Nakryiko wrote:
> > > +
> > > +                       /* sanitize variable name, e.g., for static vars inside
> > > +                        * a function, it's name is '<function name>.<variable name>',
> > > +                        * which we'll turn into a '<function name>_<variable name>'.
> > > +                        */
> > > +                       sanitize_identifier(var_ident + 1);
> >
> > btw, I think we don't need sanitization anymore. We needed it for
> > static variables (they would be of the form <func_name>.<var_name> for
> > static variables inside the functions), but now it's just unnecessary
> > complication
>
> How would we handle static variables inside functions in libraries then?

That's the thing, we don't expose them (anymore) in skeletons. So we
skip anything static. Anything global should have a unique and valid C
identifier name.

>
> >
> > > +                       var_ident[0] = ' ';
> > > +
> > > +                       /* The datasec member has KIND_VAR but we want the
> > > +                        * underlying type of the variable (e.g. KIND_INT).
> > > +                        */
> > > +                       var = btf__type_by_id(btf, var->type);
> >
> > you need to use skip_mods_and_typedefs() or equivalent to skip any
> > const/volatile/restrict modifiers before checking btf_is_array()
>
> Good catch!
>
> >
> > > +
> > > +                       /* Prepend * to the field name to make it a pointer. */
> > > +                       var_ident[0] = '*';
> > > +
> > > +                       printf("\t\t");
> > > +                       /* Func and array members require special handling.
> > > +                        * Instead of producing `typename *var`, they produce
> > > +                        * `typeof(typename) *var`. This allows us to keep a
> > > +                        * similar syntax where the identifier is just prefixed
> > > +                        * by *, allowing us to ignore C declaration minutae.
> > > +                        */
> > > +                       if (btf_is_array(var) ||
> > > +                           btf_is_ptr_to_func_proto(btf, var)) {
> > > +                               printf("typeof(");
> > > +                               /* print the type inside typeof() without a name */
> > > +                               opts.field_name = "";
> > > +                               err = btf_dump__emit_type_decl(d, var_type_id, &opts);
> > > +                               if (err)
> > > +                                       goto out;
> > > +                               printf(") %s", var_ident);
> > > +                       } else {
> > > +                               err = btf_dump__emit_type_decl(d, var_type_id, &opts);
> > > +                               if (err)
> > > +                                       goto out;
> > > +                       }
> > > +                       printf(";\n");
> >
> > we can simplify this a bit around var_ident and two
> > btf_dump__emit_type_decl() invocations. We know that we are handling
> > "non-uniform" C syntax for array and func pointer, so we don't need to
> > use opts.field_name. Doing this (schematically) should work (taking
> > into account no need for sanitization as well):
> >
> > if (btf_is_array() || btf_is_ptr_to_func_proto())
> >     printf("typeof(");
> > btf_dump__emit_type_decl(... /* opts.field_name stays NULL */);
> > printf(" *%s", var_name);
> >
> > or did I miss some corner case?
>
> You didn't close the "typeof" :)

Eagle eye :)

>
> if (btf_is_array() || btf_is_ptr_to_func_proto())
>      printf("typeof(");
> btf_dump__emit_type_decl(... /* opts.field_name stays NULL */);
> if (btf_is_array() || btf_is_ptr_to_func_proto())
>      printf(")");
> printf(" *%s", var_name);
>
> If you feel that's easier to understand, sure. I don't love it but it's
> understandable enough.

all the string buffer manipulations seem worse (you can also have a
variable to record the decision whether to use typeof or not, so you
don't have to repeat verbose is_array || is_ptr_to_func_proto check)

>
> [...]
>
>
> > we don't know the name of the final object, why would we allow to set
> > any object name at all?
>
> We don't really care about the final object name but we do need an object name
> for the subskeleton. The subskeleton type name, header guard etc all use it.
> We can say that it's always taken from the file name, but giving the user the
> option to override it feels right, given the parallel with skeletons (and what
> would we do if the file name is a pipe from a subshell invocation?).

Ah, I see, it's sort of like "library name" in this case. Yeah, makes
sense, missed that part. I was too much focused on not letting it get
into map names :)

>
> > >
> > > +
> > > +       /* The empty object name allows us to use bpf_map__name and produce
> > > +        * ELF section names out of it. (".data" instead of "obj.data")
> > > +        */
> > > +       opts.object_name = "";
> >
> > yep, like this. So that "name" argument "support" above is bogus,
> > let's remove it
>
> See above, it changes real things.

yep, my bad

>
> >
> > > +       obj = bpf_object__open_mem(obj_data, file_sz, &opts);
> > > +       if (!obj) {
> > > +               char err_buf[256];
> > > +
> > > +               libbpf_strerror(errno, err_buf, sizeof(err_buf));
> > > +               p_err("failed to open BPF object file: %s", err_buf);
> > > +               obj = NULL;
> > > +               goto out;
> > > +       }
> > > +
> >
> > [...]
> >
> > > +               for (i = 0; i < len; i++, var++) {
> > > +                       var_type = btf__type_by_id(btf, var->type);
> > > +                       var_name = btf__name_by_offset(btf, var_type->name_off);
> > > +
> > > +                       if (btf_var(var_type)->linkage == BTF_VAR_STATIC)
> > > +                               continue;
> > > +
> > > +                       var_ident[0] = '\0';
> > > +                       strncat(var_ident, var_name, sizeof(var_ident) - 1);
> > > +                       sanitize_identifier(var_ident);
> > > +
> > > +                       /* Note that we use the dot prefix in .data as the
> > > +                        * field access operator i.e. maps%s becomes maps.data
> > > +                        */
> > > +                       codegen("\
> > > +                       \n\
> > > +                               s->vars[%4$d].name = \"%1$s\";              \n\
> > > +                               s->vars[%4$d].map = &obj->maps%3$s;         \n\
> > > +                               s->vars[%4$d].addr = (void**) &obj->%2$s.%1$s;\n\
> > > +                       ", var_ident, ident, bpf_map__name(map), var_idx);
> >
> > map reference should be using ident, not bpf_map__name(), as it refers
> > to a field. The way it is now it shouldn't work for custom
> > .data.my_section case (do you have a test for this?) You shouldn't
> > need bpf_map__name() here at all.
>
> Good catch, I'll add a .data.custom test.
>
> [...]
>
> >
> > > +               "       %1$s %2$s subskeleton FILE [name OBJECT_NAME]\n"
> >
> > [name OBJECT_NAME] should be supported
>
> Not sure what you mean by "supported" here.

"not" was missing, but we just concluded that it is indeed needed

>
> >
> > >                 "       %1$s %2$s min_core_btf INPUT OUTPUT OBJECT [OBJECT...]\n"
> > >                 "       %1$s %2$s help\n"
> > >                 "\n"
> > > @@ -1788,6 +2250,7 @@ static int do_min_core_btf(int argc, char **argv)
> > >  static const struct cmd cmds[] = {
> > >         { "object",             do_object },
> > >         { "skeleton",           do_skeleton },
> > > +       { "subskeleton",        do_subskeleton },
> > >         { "min_core_btf",       do_min_core_btf},
> > >         { "help",               do_help },
> > >         { 0 }
> > > --
> > > 2.34.1
>
> -- Delyan
>
