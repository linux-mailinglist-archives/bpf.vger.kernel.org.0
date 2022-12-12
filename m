Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AE764A571
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 18:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiLLREL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 12:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiLLREI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 12:04:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5C9265D
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 09:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670864586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7GxBA4qW0FdZRbMQPW5n8Q6OaZIVNCM6Md3jYNsKrg=;
        b=B1JPxvBrhuK+5sWqx+4xMwMABJw9gDC2quuHLypZG3PI8yrDlBfrwWLmuXzZye6vs7AhtO
        KNlmI/khj91PQqh64ulDcf+Jp6/k1b4mfRE9htZUKm/rNC9smA03lyVpMutBwMnNHEnA6p
        PEh6/oLKxwuTQBQS5idXUU9WmqtwyjI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-550-xCpPOvuCOOCV4mRYVSc_ig-1; Mon, 12 Dec 2022 12:03:04 -0500
X-MC-Unique: xCpPOvuCOOCV4mRYVSc_ig-1
Received: by mail-io1-f69.google.com with SMTP id o22-20020a6b5a16000000b006e2d564944aso230136iob.7
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 09:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7GxBA4qW0FdZRbMQPW5n8Q6OaZIVNCM6Md3jYNsKrg=;
        b=nHK8vreOMxf5Egnu3VBChGs7FEyhF8NZY6ouBWtDR9T0/vsQajscJVnTsEQJvs+y/o
         3AjOy/ZRwWLR0WRSMSJn7FcvXundRblBhI0So3v0nxVLx6z0co/9MTUBrqOvCXTxVvgP
         eLlu1U9s6ejfqWBaDvvmK0rUNFnXGtiCVOtv5V7C0L1diXe/ipB1R4YuV4WwiPlxegC3
         PJrx0SZMzQ7ozHyFw0VGw0V1KpN7j+IbMN1Nu3iUET+caq4M+chHp8DaGCh1h9n2/uf1
         UF3jCWR0egmNOyd7dQkH/FSUVaB/gsALiKeJn/XuOd+igtRg9x6uEwh2N0YES1o7cxSL
         hORw==
X-Gm-Message-State: ANoB5pmkwziXl3NAeUgqgQNTJ7URMJSL1due5auqde2TFlqsgi1/kaSW
        SJa4gpsT2MX0gCnSJepGlY/cXX7gF7H0u9z/TD+1/WCA8HMODHV6fi5O7JrcEgkAhiWz1Mhn70y
        PspSyHNIp8qRtfTFpQXHsIcjs1njp
X-Received: by 2002:a92:db42:0:b0:303:26c0:e1fe with SMTP id w2-20020a92db42000000b0030326c0e1femr19505901ilq.102.1670864584076;
        Mon, 12 Dec 2022 09:03:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf78vVv6O5v0AaOvNCy3ZY7DHOhwUvmJHVpzW4vlVEy2P9BFQMDFFE0qYXuJ4gUjqxDmNFyMJjL8dyQD9Gfzg7o=
X-Received: by 2002:a92:db42:0:b0:303:26c0:e1fe with SMTP id
 w2-20020a92db42000000b0030326c0e1femr19505893ilq.102.1670864583782; Mon, 12
 Dec 2022 09:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com> <20221103155756.687789-6-benjamin.tissoires@redhat.com>
In-Reply-To: <20221103155756.687789-6-benjamin.tissoires@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 12 Dec 2022 18:02:52 +0100
Message-ID: <CAO-hwJ+fYvpD5zbDNq-f-gUEVpxsrdJ7K-ceNd37nLxzBxYL+g@mail.gmail.com>
Subject: Re: [PATCH hid v12 05/15] HID: bpf jmp table: simplify the logic of
 cleaning up programs
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 3, 2022 at 4:58 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Kind of a hack, but works for now:
>
> Instead of listening for any close of eBPF program, we now
> decrement the refcount when we insert it in our internal
> map of fd progs.
>
> This is safe to do because:
> - we listen to any call of destructor of programs
> - when a program is being destroyed, we disable it by removing
>   it from any RCU list used by any HID device (so it will never
>   be called)
> - we then trigger a job to cleanup the prog fd map, but we overwrite
>   the removal of the elements to not do anything on the programs, just
>   remove the allocated space
>
> This is better than previously because we can remove the map of known
> programs and their usage count. We now rely on the refcount of
> bpf, which has greater chances of being accurate.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> ---

So... I am a little bit embarrassed, but it turns out that this hack
is not safe enough.

If I compile the kernel with LLVM=1, the function
bpf_prog_put_deferred() is optimized in a weird way: if we are not in
irq, the function is inlined into __bpf_prog_put(), but if we are, the
function is still kept around as it is called in a scheduled work
item.

This is something I completely overlooked: I assume that if the
function would be inlined, the HID entrypoint BPF preloaded object
would not be able to bind, thus deactivating HID-BPF safely. But if a
function can be both inlined and not inlined, then I have no
guarantees that my cleanup call will be called. Meaning that a HID
device might believe there is still a bpf function to call. And things
will get messy, with kernel crashes and others.

An easy "fix" would be to tag bpf_prog_put_deferred() with "noinline",
but it just feels wrong to have that for this specific reason.

AFAICT, gcc is not doing that optimisation, but nothing prevents it
from doing it, and suddenly that will be a big whole in the kernel.

As much as I wish I had another option, I think for the sake of
everyone (and for my future holidays) I'll postpone HID-BPF to 6.3.

I actually thought of another way of removing that trampoline call. So
I'm not entirely going back to the drawing board hopefully.

[a few hours laters]

Just as a preview, I am reusing the bpf_link idea: when we call
hid_bpf_attach_prog(), this creates a bpf_link, and that link is the
one that needs to be pinned. Whenever all the references of that link
are dropped, I get called in the link's ->release() function, and I
can force the unbinding of the hid-device to the program at that time.

Way safer (no refcount mess up) and no optimisations can interfere,
now that I am not "tracing" the bpf core code.

Cheers,
Benjamin

