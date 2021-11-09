Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8D944A64D
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 06:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhKIFcj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 00:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhKIFci (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 00:32:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E8DC061764
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 21:29:52 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n8so18872755plf.4
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 21:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4DsNC5GzNOHaDAjaPC2+u9+MfH+j95NhbnjPHc6cwLY=;
        b=T0E0X5PWx9xF+tV2nHlf8hH6SpNRL0O+0iMpI5AgUifDka15SYiiRWRKZdP6dMS6JX
         sO+e90JigDf3CS37LRY+Kk39G7N9GOSG5uJyHqVl42xPkFhvpmbZjYpo0iEizRvgRsSv
         aNHLFMPCnEmcHcty4ASUaBEXm7vFm1X3xhVYX5eCyKprI/HySiGG6gx4UUHouGxx8RCo
         lbTN0ZadmOV2HkE4mABN0XJmD37w+sUyjr11f4rQP+ic9lzfYU/lrUHHmT0zqW04KJTR
         lY3CADlsG8nEFXt2iXWTZC0YzqjKm3Rh4Sc3PJW+ai8Nq1xGb5wUjIuP3v5E7AtATfBB
         jlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4DsNC5GzNOHaDAjaPC2+u9+MfH+j95NhbnjPHc6cwLY=;
        b=Hxq8FR4qra8KtW0XL/svBrd5mzgBS1m9r3po8i9rRombXm+HSgegY5m/9YosZGsGbp
         GyyJdscyuGcLcjHcSActQKOoVgRbUqaLdSaGziLDLj8JXfqm5Et5KCASC6/IF/NYokHZ
         Dp8ZsEyaDQe2bVWOGmGdu+NmLtxJC8K8BVQKY6tMFvujlJHx7XC4TL4UGja2d09JQSJk
         6m1lt2MbnCRcDPgXtXZ1FSLfhjaS3GXuh+EEV1F1588grsAY0Ihbpc9mcniHBZlrKjS4
         j5MqOyH12qgqB4TeWo2lzmqOrHJvFTiUzoVWjyKVWuOsIzRKcNFvxcagdRDP8tdhkb05
         WvTg==
X-Gm-Message-State: AOAM530HdYNbmRBISTc2dZdluzfQALZAsbV4+hLLc7QkHEsJzTkIf52N
        XJLtgHWGPFQGTpVGluDzYOpQ9ZkjhRtovlpLltl6ChkEd34=
X-Google-Smtp-Source: ABdhPJxRU+mtpLIYQqs2CfQ9ozmdMKbprxEaJSYe/yRkmCTzoDZ+XZVNsJkWxrN0/av6gwScqwbwArViDf5j4uR9dBk=
X-Received: by 2002:a17:902:d491:b0:142:892d:a89 with SMTP id
 c17-20020a170902d49100b00142892d0a89mr4808725plg.20.1636435792326; Mon, 08
 Nov 2021 21:29:52 -0800 (PST)
MIME-Version: 1.0
References: <36467ea3-8b19-f385-c2d0-02e2bd9c934e@polito.it>
In-Reply-To: <36467ea3-8b19-f385-c2d0-02e2bd9c934e@polito.it>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 8 Nov 2021 21:29:41 -0800
Message-ID: <CAADnVQLszubAWyq+Mch0xRneyhVpqNwQhrW3u_eocN6NzRcpEw@mail.gmail.com>
Subject: Re: Add variable offset to packet pointer in XDP/TC programs
To:     Federico Parola <federico.parola@polito.it>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 8, 2021 at 6:04 AM Federico Parola
<federico.parola@polito.it> wrote:
>
> Dear all,
> I found out that every time an offset stored in a 2 (or more) bytes
> variable is added to a packet pointer subsequent checks against packet
> boundaries become ineffective.
> Here is a toy example to test the problem (it doesn't do anything useful):
>
> int test(struct __sk_buff *ctx) {
>      void *data = (void *)(long)ctx->data;
>      void *data_end = (void *)(long)ctx->data_end;
>
>      /* Skipping an amount of bytes stored in __u8 works */
>      if (data + sizeof(__u8) > data_end)
>          return TC_ACT_OK;
>      bpf_trace_printk("Skipping %d bytes", *(__u8 *)data);
>      data += *(__u8 *)data;
>
>      /* Skipping an amount of bytes stored in __u16 works but... */
>      if (data + sizeof(__u16) > data_end)
>          return TC_ACT_OK;
>      bpf_trace_printk("Skipping %d bytes", *(__u16 *)data);
>      data += *(__u16 *)data;
>
>      /* ...this check is not effective and packet access is rejected */
>      if (data + sizeof(__u8) > data_end)
>          return TC_ACT_OK;
>      bpf_trace_printk("Next byte is %x", *(__u8 *)data);
>
>      return TC_ACT_OK;
> }
>
> My practical use case would be skipping variable-size TLS header
> extensions until I reach the desired one (the length of these options is
> 2 bytes long).
> Another use case can be found here:
> https://lists.iovisor.org/g/iovisor-dev/topic/access_packet_payload_in_tc/86442134
> After I use the bpf_skb_pull_data() I would like to directly jump to the
> part of packet I was working on and avoid re-parsing everything from
> scratch, however if I save the offset in a 2 bytes variable and then add
> it to the packet pointer I'm no longer able to access it (if the offset
> is stored in a 1 byte var everything works).
>
> Is this a verifier bug?

It's because of:
        if (dst_reg->umax_value > MAX_PACKET_OFF ||
            dst_reg->umax_value + dst_reg->off > MAX_PACKET_OFF)
                /* Risk of overflow.  For instance, ptr + (1<<63) may be less
                 * than pkt_end, but that's because it's also less than pkt.
                 */
                return;

by adding u16 scalar the offset becomes bigger than MAX_PACKET_OFF.
Could you try clamping the value before 'data += ' ?
