Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60AD6699AA
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 15:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbjAMOOI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 09:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241956AbjAMONi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 09:13:38 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA855EC06
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 06:11:18 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4a263c4ddbaso286377627b3.0
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 06:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JwcxadUTLm+g1Gzi28tJFADhls3BhprCF3ZKHMeFB8c=;
        b=m6dHHWEKsz5t/1GMM+CGtO+3mPdWQ60y6e9BC0g7yw454jxGxknvPPPLTCmEmvr4+o
         jQyOc5uTm1j/+eRDF0I50hd2Feu4KaSEaRbmpD2o06SjLlkrT1TLNMagfncK5ERtdEbj
         nV6zosE8jrW6+DMO9ozLARiNEIdu8nDbtreoE2Y5WpRZkfGvTM1kYEqcTTW7jUeIST7k
         z7rd+2fGwpJ2RnAmmYf9rZOA/yMB9IqFh0opcUqd99mboBSssoXGZ0xD8KclWqF4HIXF
         YygEy4q7kJm5t9G6gcnUNlKUaX33+UerA/6rA601GCFdTjfWAySi6NG1+tKsJYkrP2nk
         aRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwcxadUTLm+g1Gzi28tJFADhls3BhprCF3ZKHMeFB8c=;
        b=TugK7eAPBulKnhILY0NnrKJJlAr7fFRi4vdEj53EACJNJFTa/KP/uWqRkUxqtfOgpE
         +TRBUAuSG9nRQK5e6UeoJiSn0+neHUt9FZWV40jQqBcRPcg6KKwjtg7S5clVPJ171F8D
         LUWPe6LVvXsVfznErUmIscpiNyY0JIXJpkxSJ0aMu/TlvDzSxGdHQ2GPVMhzz0silhy9
         qftfR/hPnV0CQpqJjjHz97SVmgvmDxbUhkUPgoK8qNgyaNIGJ5ZTjsc/dI8nzRQproTH
         FGC+2NfcuSK5AOxhJC/9X9xu4/3BfBeCnr5ufWP7U3dzwpnpqhqNqoEm7Bd6yk3mUIXD
         XxpQ==
X-Gm-Message-State: AFqh2koQqmHXYM6JP2jF1dH76aKNXysTsIIzrHrXghXmFZq1INsesiYP
        biM6JYj9UgSW2K5zYY7EHqIoXBOFcspMgTqQUWDMVQ==
X-Google-Smtp-Source: AMrXdXvU5JfvAAWL0e7p6VmuPpU24WUoF5wJWXi8HRTv8y/3bwzSTuA6Bhn8ktIjh+KacUTqih26yptuVyXPtABbTPA=
X-Received: by 2002:a81:72c6:0:b0:4bb:c96d:f685 with SMTP id
 n189-20020a8172c6000000b004bbc96df685mr4321344ywc.208.1673619077771; Fri, 13
 Jan 2023 06:11:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673574419.git.william.xuanziyang@huawei.com> <b268ec7f0ff9431f4f43b1b40ab856ebb28cb4e1.1673574419.git.william.xuanziyang@huawei.com>
In-Reply-To: <b268ec7f0ff9431f4f43b1b40ab856ebb28cb4e1.1673574419.git.william.xuanziyang@huawei.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Fri, 13 Jan 2023 09:10:41 -0500
Message-ID: <CA+FuTSfwZNBMnuUXgLOq8Z4s5es13tmK=oPNFWsWG22ztmWQLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add ipip6 and ip6ip decap support
 for bpf_skb_adjust_room()
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 13, 2023 at 4:25 AM Ziyang Xuan
<william.xuanziyang@huawei.com> wrote:
>
> Add ipip6 and ip6ip decap support for bpf_skb_adjust_room().
> Main use case is for using cls_bpf on ingress hook to decapsulate
> IPv4 over IPv6 and IPv6 over IPv4 tunnel packets.
>
> Add two new flags BPF_F_ADJ_ROOM_DECAP_L3_IPV{4,6} to indicate the
> new IP header version after decapsulating the outer IP header.
>
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
