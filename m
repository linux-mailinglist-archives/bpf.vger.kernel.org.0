Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CA35872F4
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 23:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiHAVQi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 17:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiHAVQh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 17:16:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E0ABA8
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 14:16:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x21so2627593edd.3
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 14:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10+pOC0ken+V8y1DxPGxkip0TGDf2LzkvFWwcjkXjpQ=;
        b=MBrw0gGiqqybBuCVRVE+PCR4YWs9SkI6i8A/6tfbYbvRxzWBVQCvGtXpRioG91uahf
         oVPlnRYaYcT81x7IjQOYWOdQQqjM05vcuE5+6jm1etVXbmsz+/f9NTA7xdrMMrNDElFa
         /h+aOn3i/9CmCh6wnDcSOTlRvBmOhqZVBTPNDBAmhfW0JoQ0ZhqOMiajajtEpMVBPe6X
         HO9hNsC/Ud/YE0U43oWbd6Q5YXcBXPk+L2I9xBfCWXJ5jtXQ5ky4gY/OhYfLkz4pxdmp
         WET5fdAH7fgnp9J0WvHMVjVaX6YKkDeXPGkZTMnRe9WKGclZkq2zsG4fUzAA12v0Hn9n
         dTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10+pOC0ken+V8y1DxPGxkip0TGDf2LzkvFWwcjkXjpQ=;
        b=Kf29qoXJvY5p80nQevEtpp8MseR+30dEnmj5QTkLdNRT77B7Wk1G/MNVQl5W1dV80E
         1HfBvQcZxD9+MQ5evLZMp9g/6+ugZ6H3QCjWtKPIXEkI3zlb4/afnqyrgqr6hEJW3Cv2
         kYl/juak67qtlKXsqdYT+x6lFTLWaTSHCMsxABkMnvWwENsLNdZ3CBxlZC2wxxhmKy65
         31+MYrS7C/FqAGBZhZ/6JZOMO+M1+Q+s5oYLvkAblyToRiidVKOuZxRdmaob56GYax9e
         mRDoH2ViQJ2C8uOyNh/UoTPC81c/MaTcNFezeQi/0ilzJ/X55c9hSF5KNsl6yR8SaiKU
         bd0w==
X-Gm-Message-State: AJIora8lZmBB1450shCXukethlflGA1n4FBOGzydH03TmQ/O6QRKuxIt
        7+raJgomSBeMAFZuuUCJ9RZ8FFRn3rVWr9twyTs=
X-Google-Smtp-Source: AGRyM1vRqQUgGy8shNrVyvCuxxT8ZE268+BrtSfMB35vJBqO2jfwdOGZJ+1xuB/Qlrh7HFyhc4F53EyVEe53yUnEm3c=
X-Received: by 2002:a50:fb13:0:b0:43c:ef2b:d29 with SMTP id
 d19-20020a50fb13000000b0043cef2b0d29mr17935849edq.378.1659388594735; Mon, 01
 Aug 2022 14:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
 <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1YXSx11TGhKhAZ20R81pUsgBVeAooGJjTR7dR5iyP_eeQ@mail.gmail.com> <20220801193850.2qkf6uiic7nrwrfm@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220801193850.2qkf6uiic7nrwrfm@kafai-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 1 Aug 2022 14:16:23 -0700
Message-ID: <CAJnrk1ZCQ5nRB=jBUxPFyS4OhMvDX1t4ddFYX2LqkepMZg-12w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 1, 2022 at 12:38 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Mon, Aug 01, 2022 at 10:52:14AM -0700, Joanne Koong wrote:
> > > Since we are on bpf_dynptr_write, what is the reason
> > > on limiting it to the skb_headlen() ?  Not implying one
> > > way is better than another.  would like to undertand the reason
> > > behind it since it is not clear in the commit message.
> > For bpf_dynptr_write, if we don't limit it to skb_headlen() then there
> > may be writes that pull the skb, so any existing data slices to the
> > skb must be invalidated. However, in the verifier we can't detect when
> > the data slice should be invalidated vs. when it shouldn't (eg
> > detecting when a write goes into the paged area vs when the write is
> > only in the head). If the prog wants to write into the paged area, I
> > think the only way it can work is if it pulls the data first with
> > bpf_skb_pull_data before calling bpf_dynptr_write. I will add this to
> > the commit message in v2
> Note that current verifier unconditionally invalidates PTR_TO_PACKET
> after bpf_skb_store_bytes().  Potentially the same could be done for
> other new helper like bpf_dynptr_write().  I think this bpf_dynptr_write()
> behavior cannot be changed later, so want to raise this possibility here
> just in case it wasn't considered before.

Thanks for raising this possibility. To me, it seems more intuitive
from the user standpoint to have bpf_dynptr_write() on a paged area
fail (even if bpf_dynptr_read() on that same offset succeeds) than to
have bpf_dynptr_write() always invalidate all dynptr slices related to
that skb. I think most writes will be to the data in the head area,
which seems unfortunate that bpf_dynptr_writes to the head area would
invalidate the dynptr slices regardless.

What are your thoughts? Do you think you prefer having
bpf_dynptr_write() always work regardless of where the data is? If so,
I'm happy to make that change for v2 :)

>
> Thinking from the existing bpf_skb_{load,store}_bytes() and skb->data perspective.
> If the user changes the skb by directly using skb->data to avoid calling
> load_bytes()/store_bytes(), the user will do the necessary bpf_skb_pull_data()
> before reading/writing the skb->data.  If load_bytes()+store_bytes() is used instead,
> it would be hard to reason why the earlier bpf_skb_load_bytes() can load a particular
> byte but [may] need to make an extra bpf_skb_pull_data() call before it can use
> bpf_skb_store_bytes() to store a modified byte at the same offset.
