Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A6C23C03E
	for <lists+bpf@lfdr.de>; Tue,  4 Aug 2020 21:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgHDTmz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Aug 2020 15:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgHDTmy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Aug 2020 15:42:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95884C06174A
        for <bpf@vger.kernel.org>; Tue,  4 Aug 2020 12:42:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e196so49215314ybh.6
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2020 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cdYPSZUd3OatsI0N2mJT6Y0zlsGcSNspGceuQDdHfGA=;
        b=micRWL4x2QTclJkUgCnKW76kVXv88G1qdEnngEBl6vEXQqRV+U46syJIYBHy1CmHRP
         ivNVSH7D2Gg/KEN6slemZYhRkPBWCtQ7F0aidzibF8vvsjDULzYpPhkdIQSkL8LQvlSQ
         Md621SO9okyyyoJ+hppSijAy7aDJtDDcV9Ah8ApeCc+dqfoXbMrMffuKoA02cuOlChl2
         TmiDSWzDS+3QZJXHQ8dt8HPWw02uYkJK3/Q2nivTNyLjcUlnQe6iMAnArbgMSXqtf2lG
         mh2FDJBQA7K8ul9NIhFVRQ0nwK3gsMyv7VxlX+rNLOnHAdJ86bnOIwlu1jVwlnhrd1l3
         IwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cdYPSZUd3OatsI0N2mJT6Y0zlsGcSNspGceuQDdHfGA=;
        b=X12lARoOhMCSg1jbR53DfpdlLHupic/hHAqw05GalBm8iegzgxdoDHpmYi7SEyKXZS
         NyJmn4tkKpnCN5QhC+2nnxmYb5gnfm33Lv0MFSo4YROM38bKOcVsKyYlVYQ30s5c51PW
         7+LM/8rJb6yhnM5FcFZEl7YHEaYiwJnMXgl4FuPEyrYQOpx3kht5C9WabMW93Nha3Gbu
         7u+xzLIVOyi+pHIVbVPT9KP2m97J1Pheyo12IlWR6DgzBmULgMOQpToX1UAPnIGmQgSK
         a1/vdgFHdSdYF4tjgjBeH/xIJuvq3+4utRlutPNskiD3tBjtyGB4sttmgl2GUlCny0ac
         AZ7Q==
X-Gm-Message-State: AOAM5317+VFBX3urzqC4jF/CZTAaH3RuiVYVXzquhqC6v9o0cmxu3uVd
        oF7Foyd02hkULwZNaBAmg2erI+aLvK6oRn9/U+ab89gLXcwnzSIfkHJlAiHxfR+FUGVEjTp9MHd
        0d0PgYfiEURbyzPNg/Iia2j08vJhE3W6inl0bfJGlvjED+pDmHQ==
X-Google-Smtp-Source: ABdhPJyo7Tr1kh/5D7He+45q4SXvXGwYVjW6A/JrOWGtm25TUylxVvGtxNdUSXeLkBy0JUfQ61yD4ak=
X-Received: by 2002:a25:d295:: with SMTP id j143mr20497963ybg.319.1596570173739;
 Tue, 04 Aug 2020 12:42:53 -0700 (PDT)
Date:   Tue, 4 Aug 2020 12:42:51 -0700
In-Reply-To: <20200729162751.GC184844@google.com>
Message-Id: <20200804194251.GE184844@google.com>
Mime-Version: 1.0
References: <20200729162751.GC184844@google.com>
Subject: Re: BPF program metadata
From:   sdf@google.com
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andriin@fb.com,
        zhuyifei@google.com, maheshb@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/29, sdf@google.com wrote:
> As discussed in
> https://docs.google.com/presentation/d/1A9Anx8JPHl_pK1aXy8hlxs3V5pkrKwHHtkPf_-HeYTc
> during BPF office hours, we'd like to attach arbitrary auxiliary
> metadata to the program, for example, the build timestamp or the commit
> hash.

> IIRC, the suggestion was to explore BTF and .BTF.ext section in
> particular.
> We've spent some time looking at the BTF encoding and BTF.ext section
> and we don't see how we can put this data into .BTF.ext or even .BTF
> without any kernel changes.

> The reasoning (at least how we see it):
> * .BTF.ext is just a container with func_info/line_info/relocation_info
>    and libbpf extracts the data form this section and passes it to
>    sys_bpf(BPF_PROG_LOAD); the important note is that it doesn't pass the
>    whole container to the kernel, but passes the data that's been
>    extracted from the appropriate sections
> * .BTF can be used for metadata, but it looks like we'd have to add
>    another BTF_INFO_KIND() to make it a less messy (YiFei, feel free to
>    correct me)

> So the question is: are we missing something? Is there some way to add
> key=value metadata to BTF that doesn't involve a lot of kernel changes?

> If the restrictions above are correct, should we go back to trying to
> put this metadata into .data section (or maybe even the new .metadata
> section)? The only missing piece of the puzzle in that case is the
> ability to extend BPF_PROG_LOAD with a way to say 'hold this map
> unconditionally'.
Should we have a short discussion about that this Thu during the office
hours? I don't see this week's sheet page in there yet :-(
