Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F536DA70B
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 03:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjDGBoF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 21:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjDGBoE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 21:44:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97504618B;
        Thu,  6 Apr 2023 18:44:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso7146372pjc.1;
        Thu, 06 Apr 2023 18:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680831843; x=1683423843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Of478TmHdbvGaBEH1hgy6xl4bV9ps/ooDVMDf4nzGk=;
        b=Kp4CBd2MyaGDYTJU9pq487Ud4NQC6jUS0wYyrqeU8L6Q6YlQ9nGTZ4owUpsCkfB8E0
         Ddszg7jyPrXnqGZgz+l/AP91uJrbtEkQQpyh9nopkSStktIi6nB2EyuaLPVJetHrdHEX
         QLgt4+kXuO4XU7J5jsIHsc01cfDLdQ/yHxqhfjS3mVZp5DE3jxEhc2F4YAFOfqxnru01
         Jn6CCQgrwRY56YHf8e5zs3Xg7hlkhc0lZaGQZ1HfscQw+S+nVtlJ9t2GPFAIT/3npipf
         x3/laf6BEPR74w+0ZGV0n+C9Y/k0KIE/t+GEc6afrXlYwRxUE+9eCdeBLF1aqSUNcVq6
         090g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680831843; x=1683423843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Of478TmHdbvGaBEH1hgy6xl4bV9ps/ooDVMDf4nzGk=;
        b=41cX+KXOxYofwF4NymfugsZu/X2bOso3p6Bl4YXEvDVCL2od1y6YlWcZf8bjcdioWM
         qLvivOvplNoJOfDl8OpaMGUI/XfD522VJixuQHZ9Ti6ga6PWH2kK+MCv9hLABRK0djBL
         JasxdbzgkL8woZeInDt5Edd37bWZKZXpnLGvGEQtU+A3K66rS1iNIC1NJ0ghWbdm/b9S
         nZfCvBIrLFuv81+29iBruICN1fdQV/kfSN+wW1Dy6iiUC+VCJ41GsAU1VIc5W0ewqLj0
         Sgsn1A2WKf8HVUu8t4zGJ2Oc3abH8765xQRsceiIEijvNS8k2lL9p1gfenI86fMbQ76C
         HDIA==
X-Gm-Message-State: AAQBX9cqv+oKAyTp/VDTluQ8HAAtHIgAI0Ig2bmgwxyBzjaKA5HXhJIp
        AY0dcs8stxNf+FjacDIeVV+qSUrUPNM=
X-Google-Smtp-Source: AKy350ZwVFBxUYtpec9tAEbQiWYXkZ983yORQ/50Jw3c8jyYwAgmLl+/ucoqJJKRJd/APAZeuaX4YA==
X-Received: by 2002:a17:90b:388e:b0:23e:aba9:d51d with SMTP id mu14-20020a17090b388e00b0023eaba9d51dmr687840pjb.7.1680831842869;
        Thu, 06 Apr 2023 18:44:02 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:5abd])
        by smtp.gmail.com with ESMTPSA id jx20-20020a17090b46d400b0023f355a0bb5sm1776242pjb.14.2023.04.06.18.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 18:44:02 -0700 (PDT)
Date:   Thu, 6 Apr 2023 18:43:59 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
Message-ID: <20230407014359.m6tff5ffemvrsyt3@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <CALOAHbBj-+xY5jGLynUrg1GfSftZ+LT5DkADKz_+8+tL2kWMSw@mail.gmail.com>
 <20230403225017.onl5pbp7h2ugclbk@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbDQROKrWe732Qv1CsZwr6nMJN-2y77JW3EuT53D8At+Ow@mail.gmail.com>
 <20230406020656.7v5ongxyon5fr4s7@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbCEsucGRB+n5hTnPm-HssmB91HD4PFVRhdO=CZnJXfR6A@mail.gmail.com>
 <CAADnVQ+1VEBHTM5Rm-gx8-bg=tfv=4x+aONhF0bAmBFZG3W8Qg@mail.gmail.com>
 <CALOAHbAorooyteDjgs82TtujP4Fwo5hSkh-Z5QhxhV9p7_2mfw@mail.gmail.com>
 <CAADnVQKr5Y3z9f_Vv49DvRFcN+OF3JaFx_9NgBL58pz+TLq8ig@mail.gmail.com>
 <CALOAHbDdtj1Qd0h1jzXKN4R=_webEVW=sqYfhSFXXsYftyvnKw@mail.gmail.com>
 <CAEf4Bza_vM8HE5g+4ANW3NAAt8=+cn7Lw+DSkH42gimqzYxPdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza_vM8HE5g+4ANW3NAAt8=+cn7Lw+DSkH42gimqzYxPdw@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 06, 2023 at 01:22:26PM -0700, Andrii Nakryiko wrote:
> On Wed, Apr 5, 2023 at 10:44 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Thu, Apr 6, 2023 at 12:24 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Apr 5, 2023 at 8:22 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > On Thu, Apr 6, 2023 at 11:06 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Wed, Apr 5, 2023 at 7:55 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > > >
> > > > > > It seems that I didn't describe the issue clearly.
> > > > > > The container doesn't have CAP_SYS_ADMIN, but the CAP_SYS_ADMIN is
> > > > > > required to run bpftool,  so the bpftool running in the container
> > > > > > can't get the ID of bpf objects or convert IDs to FDs.
> > > > > > Is there something that I missed ?
> > > > >
> > > > > Nothing. This is by design. bpftool needs sudo. That's all.
> > > > >
> > > >
> > > > Hmm, what I'm trying to do is make bpftool run without sudo.
> > >
> > > This is not a task that is worth solving.
> > >
> >
> > Then the container with CAP_BPF enabled can't even iterate its bpf progs ...
> 
> I'll leave the BPF namespace discussion aside (I agree that it needs
> way more thought).
> 
> I am a bit surprised that we require CAP_SYS_ADMIN for GET_NEXT_ID
> operations. GET_FD_BY_ID is definitely CAP_SYS_ADMIN, as they allow
> you to take over someone else's link and stuff like this. But just
> iterating IDs seems like a pretty innocent functionality, so maybe we
> should remove CAP_SYS_ADMIN for GET_NEXT_ID?
> 
> By itself GET_NEXT_ID is relatively useless without capabilities, but
> we've been floating the idea of providing GET_INFO_BY_ID (not by FD)
> for a while now, and that seems useful in itself, as it would indeed
> help tools like bpftool to get *some* information even without
> privileges. Whether those GET_INFO_BY_ID operations should return same
> full bpf_{prog,map,link,btf}_info or some trimmed down version of them
> would be up to discussion, but I think getting some info without
> creating an FD seems useful in itself.
> 
> Would it be worth discussing and solving this separately from
> namespacing issues?

Iteration of IDs itself is fine. The set of IDs is not security sensitive,
but GET_NEXT_BY_ID has to be carefully restricted.
It returns xlated, jited, BTF, line info, etc
and with all the restrictions it would need something like
CAP_SYS_PTRACE and CAP_PERFMON to be useful.
And with that we're not far from CAP_SYS_ADMIN.
Why bother then?
