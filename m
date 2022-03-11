Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1984D68FC
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 20:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbiCKTM3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 14:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiCKTM2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 14:12:28 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CBF1B8FF2;
        Fri, 11 Mar 2022 11:11:25 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id b14so6650643ilf.6;
        Fri, 11 Mar 2022 11:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZ4G1abLpX1+7FOiIPFq4p8zwTFy2fU8JzBB043JMrU=;
        b=WCKzDTLSv5sImvRmJ5fYFhGVQ7cxKmL6C4Ca7BUKJsOjSoxLYYCmovQmdJd1i7TJma
         tmdzE+NuUN4rreBhoswlO+sGDsN9eG+kxxScRQK4Jz9zPqIZBl4HlnFIEzUgeAFBvxx7
         9WFthOB4dbTGLx3XZoFFCJZvkUnaE1EyRgWnqdyZ3bRjZctuBStydqAlM4qqavMDgtMd
         ge69m5DYx1fdi+gm3wNC3eWpOkS9farucoZDgVqoBe0uq54FXH1WxQxTNYbizlvWb6J6
         v7XibIjbPyNrFz1E3eHmv8UiwzzF2DQZ1KKlP11zjMSPoOPKauCjhSVySPUN4YsotS3v
         6zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZ4G1abLpX1+7FOiIPFq4p8zwTFy2fU8JzBB043JMrU=;
        b=6b2PbSbVhrjRBfnhm14DvNkpWM2gHQgtjjrjeCpffkdggHk1Wrhq91Yd1hMf/wcyra
         cHqNP2eypfyYTLZdI2CMY9JBbHU6lLBo+XCG551kRNj38azQz6JZdi6vIL4PkoGfT7ZD
         z6yrf8txPydaB55ipst+GU8AoN8/uPyjph7ClosY7Vz9D3JMY/dJS0QP8poL8zhDQLS+
         ptBfoabf5FkUaGrhM9C8H9FPl15tGir6lyw2QSX/pRPnrR7IwNoflUDhG8Raj1HCdY5w
         2irLIuUlpEUHbuIgEZhU5gXO3DYEc0uSX8zFNTLobw5XZ109OxYZXFVPlx9Bt0z2SqDr
         Q1ag==
X-Gm-Message-State: AOAM5331hXFhyKxqUFPnYO80zWcsE9oXzMJO3Ks7w81wAvTz18bj9NyZ
        AwTPm0Ti2TOzOe9FpIFBsFiLtxf71UZjZJEih3s=
X-Google-Smtp-Source: ABdhPJzaunPVLCWbbdAT3/2L20Il8HLCeB/vZKDv2c9sbUYwJkO14EyW5dX6GeYXtBUuP4PBknPxTgcRjuwTsEY8JI0=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr8885290ilb.305.1647025884602; Fri, 11
 Mar 2022 11:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20220224000531.1265030-1-haoluo@google.com> <a7f26f93-c5f8-2abc-e186-5d179706ae8e@soleen.com>
 <CA+khW7hwT0PSiToAJcdX1Te9QwhWL671sMX+92VS+V6Zsp+0Vg@mail.gmail.com>
In-Reply-To: <CA+khW7hwT0PSiToAJcdX1Te9QwhWL671sMX+92VS+V6Zsp+0Vg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Mar 2022 11:11:13 -0800
Message-ID: <CAEf4BzYa1o5FYWGY3tt6O_7LK5h+NmiFzM9QhnKA5n3w-3=p7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Cache the last valid build_id.
To:     Hao Luo <haoluo@google.com>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
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

On Thu, Mar 10, 2022 at 5:16 PM Hao Luo <haoluo@google.com> wrote:
>
> On Fri, Feb 25, 2022 at 12:43 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On 2/23/22 19:05, Hao Luo wrote:
> > > For binaries that are statically linked, consecutive stack frames are
> > > likely to be in the same VMA and therefore have the same build id.
> > > As an optimization for this case, we can cache the previous frame's
> > > VMA, if the new frame has the same VMA as the previous one, reuse the
> > > previous one's build id. We are holding the MM locks as reader across
> > > the entire loop, so we don't need to worry about VMA going away.
> > >
> > > Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
> > > test_progs.
> > >
> > > Suggested-by: Greg Thelen <gthelen@google.com>
> > > Signed-off-by: Hao Luo <haoluo@google.com>
> >
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> >
>
> An update with performance numbers. Thanks to Blake Jones for
> collecting the stats:
>
> In a production workload, with BPF probes sampling stack trace, we see
> the following changes:
>
>  - stack_map_get_build_id_offset() is taking 70% of the time of
> __bpf_get_stackid(); it was 80% before.

Great, thanks for following up with updated numbers!

>
>  - find_get_page() and find_vma() together are taking 75% of the time
> of stack_map_get_build_id_offset(); it was 83% before.
>
> Note the call chain is
>
> __bpf_get_stackid()
>   -> stack_map_get_build_id_offset()
>     -> find_get_page()
>     -> find_vma()
>
> > Thanks,
> > Pasha
