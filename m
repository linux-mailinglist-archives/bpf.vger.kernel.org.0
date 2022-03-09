Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C834D3433
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 17:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiCIQXy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 11:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiCIQRY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 11:17:24 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE614CC95
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 08:12:05 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gb39so6168578ejc.1
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 08:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cb85cNnQa59wkZKmvUKPmJKtRRXhYLeWuHhK2nmWNpU=;
        b=HP14mJKhqrGXai6E/Aus9YW0jqKHkBneXuFCrDqViDvc1uv/srmL99PmLr1XBRxJ6C
         w3xaNFbyziZJeDWiRCs2g8tY7JCrYcw3W8wpfc0cf6sUnwaeKaFdCrxoAeP3UI1la8h4
         ymF75tyLwNywXC8YOm5HybtyFShQbhSfgdwpuixOqIpznOlVi7CU8F81bySmIvJ/jIXd
         GwkkGVyZovNXPMEtQmKz2XWXEOvPNXD7z5WPNrWH3dksbU9H95fhvQ4hZGZ/AwMRm5CO
         +xr7XMBXft32IQnPrHp62kjKLNB/rHX1gaWgFNBqoQF0LLBvGHPqyJl3InJT8WWYRDpC
         MSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cb85cNnQa59wkZKmvUKPmJKtRRXhYLeWuHhK2nmWNpU=;
        b=iCzdxNsnT8nr4fhFK9K+wjAvppImi1fdJhKqRVt94zWukurGEIumrKM15RDsuBRB3m
         UHpDbNlrUu4yOGnlOn2dk0hJeKl8YFLbECjVdEHHG51n6EUYNoSKDtMXb9c+4ktPKKuf
         aLwJ5LxM49aOuuCUn3ZlbpDG6wZ05AUW05AXHPHbCiuw7LRmv8UMOwMpt77sIJAUDK9x
         7J5+pzc5XueMIbgFTP5rxMP3IKXWWNTTr+4wIF+zMlntVP6TM/RIiBiEIHPZhzTxmVqV
         zN3bvA854l+88zSO8jNFve3X2HskkZEJ9XA7D2PG277z6WBY2WAzAKaowfAsEEDaff/e
         FmXA==
X-Gm-Message-State: AOAM532Xdgp75CLT4E1wsVBGmJDXG1XlMBUy0VwF1tPc088TcbkeZYEW
        Y+41e/2ddxYXmj13Y/kkDTQ=
X-Google-Smtp-Source: ABdhPJzmPufStlm3T/pesBO6a74IAHB2hdDvcIFSfXkmsj9iHD10Q9/qBruh5lf4woAGlj5w/l7B+w==
X-Received: by 2002:a17:906:2403:b0:6d1:ca2:4da7 with SMTP id z3-20020a170906240300b006d10ca24da7mr419506eja.533.1646842323368;
        Wed, 09 Mar 2022 08:12:03 -0800 (PST)
Received: from erthalion.local (dslb-178-005-230-047.178.005.pools.vodafone-ip.de. [178.5.230.47])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906780400b006ce69ff6050sm903704ejm.69.2022.03.09.08.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:12:02 -0800 (PST)
Date:   Wed, 9 Mar 2022 17:11:34 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v5] bpftool: Add bpf_cookie to link output
Message-ID: <20220309161134.5wctrz77wexdiplk@erthalion.local>
References: <20220304143610.10796-1-9erthalion6@gmail.com>
 <CAEf4BzbmU-94rTp2zhfp8W6u-Tjcdsk45653UyrQ5bNKFc7jLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbmU-94rTp2zhfp8W6u-Tjcdsk45653UyrQ5bNKFc7jLw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Mon, Mar 07, 2022 at 05:41:24PM -0800, Andrii Nakryiko wrote:
> On Fri, Mar 4, 2022 at 6:36 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >
> > @@ -234,6 +239,9 @@ void emit_obj_refs_plain(struct hashmap *map, __u32 id, const char *prefix)
> >                 if (refs->ref_cnt == 0)
> >                         break;
> >
> > +               if (refs->bpf_cookie_set)
> > +                       printf("\n\tbpf_cookie %llu", refs->bpf_cookie);
>
> __u64 is not always %llu on all architectures. Best to cast it to
> (unsigned long long) here to avoid compilation warnings.
>
> > @@ -38,6 +38,18 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
> >         }
> >  }
> >
> > +/* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
> > +static __always_inline __u64 get_bpf_cookie(struct bpf_link *link)
>
> no need for __always_inline
>
> > +{
> > +       struct bpf_perf_link *perf_link;
> > +       struct perf_event *event;
> > +
> > +       perf_link = container_of(link, struct bpf_perf_link, link);
> > +       event = BPF_CORE_READ(perf_link, perf_file, private_data);
> > +       return BPF_CORE_READ(event, bpf_cookie);
> > +}
> > +
> > +
>
> nit: why double empty line?
>
> > diff --git a/tools/bpf/bpftool/skeleton/pid_iter.h b/tools/bpf/bpftool/skeleton/pid_iter.h
> > index 5692cf257adb..2676cece58d7 100644
> > --- a/tools/bpf/bpftool/skeleton/pid_iter.h
> > +++ b/tools/bpf/bpftool/skeleton/pid_iter.h
> > @@ -6,6 +6,8 @@
> >  struct pid_iter_entry {
> >         __u32 id;
> >         int pid;
> > +       __u64 bpf_cookie;
> > +       bool bpf_cookie_set;
>
> naming nit: either "bpf_cookie_is_set" or "has_bpf_cookie"?
> "bpf_cookie_set" is read either as a verb or as "a set of bpf_cookies"

Yep, makes sense (this and the rest of the comments above), will post a
new version with the cumulative changes soon.
