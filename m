Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0CF19C38B
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 16:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbgDBODE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 10:03:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36365 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732484AbgDBODD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 10:03:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so4363579wrs.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2020 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ROM0NZlL8/uavKppMYhFZmhpIoRWlNeIkHl4YW1IeXQ=;
        b=dS6/5rCM4/vLn5Oy//VpCZAlhD7BDjbPJNcgTtkenuduZrGDvvix/PkbBWumdzIM4E
         Ppf1+JtrgEOi+afPPtzZJOLKh0bg0GnikmJ1cEZK77soD4Q0bjb9naI/vzr1Y2VgQnka
         SoD13n04fddvXe4/i+/tNfir/2jZslLYttg/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ROM0NZlL8/uavKppMYhFZmhpIoRWlNeIkHl4YW1IeXQ=;
        b=Fl2mLLiRJ87u15BUW+U3ZY8j2TJNf5aixTxWIBpQU9PA+wQH0aund2mjlUexxtSJm8
         cau0m5ACD+QQdoEHmdimSXnkoW0aBlUZrqnvStCueyfSkBC6q4uWwcu9VVVV7tpPoqH/
         jypystgfRikJTEPXMuM54GCZsjxKvCGEwvprZWRJxcnaiGhk8p+SaTXGJUfJ9mkw6aXo
         CUniIMxBgEBKhUG6eVIdWCQ4pY3ayOrKNbZOawA0UkeruTydjsvDonRASmNzSFpKgbX6
         4E32F+Cq5kdtGdVXyEB/4yFczmcyjWLGarYEKpkREJssZnnwa3fcKuB+nw2j4YpaTsIU
         wT0A==
X-Gm-Message-State: AGi0PuZQi4k1Fl2Lf91qAhCLMhERCEkv1R4XpjVM7ow9tak01xqOUGf0
        FrtcVfivTFLDTOVVUVenK+9mZQ==
X-Google-Smtp-Source: APiQypLJTBUL+2+4Apj1ozbT3vs8eWnc03DsQNS2UzDY9+fj4p3EejYdi/YFzBetYav6I9LGsJP2xQ==
X-Received: by 2002:a5d:498b:: with SMTP id r11mr3722281wrq.368.1585836182081;
        Thu, 02 Apr 2020 07:03:02 -0700 (PDT)
Received: from revest.fritz.box ([2a02:168:ff55:0:c8d2:c098:b5ec:e20e])
        by smtp.gmail.com with ESMTPSA id p10sm7548565wrm.6.2020.04.02.07.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:03:01 -0700 (PDT)
Message-ID: <5968eda68bfec39387c34ffaf0ecc3ed5d8afd6f.camel@chromium.org>
Subject: Re: [RFC 0/3] bpf: Add d_path helper
From:   Florent Revest <revest@chromium.org>
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Andrii Nakryiko <andriin@fb.com>, bgregg@netflix.com,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 02 Apr 2020 16:03:00 +0200
In-Reply-To: <20200401110907.2669564-1-jolsa@kernel.org>
References: <20200401110907.2669564-1-jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+build1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2020-04-01 at 13:09 +0200, Jiri Olsa wrote:
> hi,
> adding d_path helper to return full path for 'path' object.
> 
> I originally added and used 'file_path' helper, which did the same,
> but used 'struct file' object. Then realized that file_path is just
> a wrapper for d_path, so we'd cover more calling sites if we add
> d_path helper and allowed resolving BTF object within another object,
> so we could call d_path also with file pointer, like:
> 
>   bpf_d_path(&file->f_path, buf, size);
> 
> This feature is mainly to be able to add dpath (filepath originally)
> function to bpftrace, which seems to work nicely now, like:
> 
>   # bpftrace -e 'kretfunc:fget { printf("%s\n", dpath(args->ret-
> >f_path));  }' 
> 
> I'm not completely sure this is all safe and bullet proof and there's
> no other way to do this, hence RFC post.
> 
> I'd be happy also with file_path function, but I thought it'd be
> a shame not to try to add d_path with the verifier change.
> I'm open to any suggestions ;-)

First of all I want to mention that we are really interested in this
feature so thanks a lot for bringing it up Jiri! I have experimented
with similar BPF helpers in the past few months so I hope my input can
be helpful! :)

One of our use-cases is to gather information about execution events,
including a bunch of paths (such as the executable command, the
resolved executable file path and the current-working-directory) and
then output them to Perf.
Each of those paths can be up to PATH_MAX(one page) long so we would
pre-allocate a data structure with a few identifiers (to later
reassemble the event from userspace) and a page of data and then we
would output it using bpf_perf_event_output. However, with three mostly
empty pages per event, we would quickly fill up the ring buffer and
loose many events.
This might be a bit out-of-scope at this moment but one of the
teachings we got from playing with such a helper is that we would also
need a helper for outputting strings to Perf, pre-pended with a header
buffer.

