Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532D56699CF
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 15:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbjAMOPU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 09:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjAMOOD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 09:14:03 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3756E0FB
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 06:13:12 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4d19b2686a9so158529247b3.6
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 06:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=76yLym9Pl5i5ZYoGuk3TgA6N8QwIkLpItLvMIbVU+Qw=;
        b=Bd2oGgvmtvv8m3hvuYRyTPL+ce3647OKK6ub3PnG4oiOuaPdYXKRFbtQe7Y29wMjlq
         upcNBDlgD7f/VOaDtb+dOXAvGM4PZD+f2HxXcjvIaj8jDDlxA+4O1kFUeB3stEdLZlX4
         de2HfuoSCxWGhyWQRravhXgsdOaYWGBMwm78TZlMUMQxe+yq5tQH9i8NUjyURdUTeqgW
         FZADNNYdnXufibf4K80tmQlJskwGt6RjC0IAbMvYxZfTRNLlqMzVQ9iMYZvUnrGe7Y//
         funDTCKjVbREiBljq1OtetuqvDxWP0aHmev2TmTnxvsb8EbjPkPTuS/TEX8WXoLtdAf8
         KTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76yLym9Pl5i5ZYoGuk3TgA6N8QwIkLpItLvMIbVU+Qw=;
        b=A0vDCou+tpQ7Ged6xzHxO3U0ZqrLHY9ywTEHbYcTk/5LCyrYopzA7ijlyUvDMu8cCU
         VXbZM8PyDCMkeRNysboYLNcF8f9GvA7Icfk8s021h0VfVGMkUqctm9Y3PXj3aaKxwoxZ
         L8NGctbXiHm0IEAJfP9zBQXQF+3y4FMP/DZQguJEDtuoK2E+YeJ6l6HpHe0p1yKUweIS
         SnIp+KSkzbzp6K9jF1RRiDBi1cNHUqH+p0Vj99oRcePZS9p4NMtX8NDtHmGVh5BB846f
         Z4imBPnhFeHVJO0u+Wf0Wb5m0zesZB5uMovHlnA1bLQljwtw2WeH0RWMZ4FFru6TsY69
         ORxg==
X-Gm-Message-State: AFqh2kos1NTc00s/sCZlvT9TFweBwRtijbNpmta1SYszecwNay3IaiBB
        ns8o1gn2XIIZwRDacbl6MaiUQuF9d1SZcIUgX0f1bg==
X-Google-Smtp-Source: AMrXdXuNQmry0hopnvbmjTdDmMUEaKqzdqBPNc6ktLZWN1O0Mw223eC5M9150oRRIscMgWEXxHz+l7j2CVfNFUXBqhk=
X-Received: by 2002:a0d:dfca:0:b0:4dd:c62f:d65a with SMTP id
 i193-20020a0ddfca000000b004ddc62fd65amr229576ywe.427.1673619191342; Fri, 13
 Jan 2023 06:13:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673574419.git.william.xuanziyang@huawei.com> <dfd2d8cfdf9111bd129170d4345296f53bee6a67.1673574419.git.william.xuanziyang@huawei.com>
In-Reply-To: <dfd2d8cfdf9111bd129170d4345296f53bee6a67.1673574419.git.william.xuanziyang@huawei.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Fri, 13 Jan 2023 09:12:34 -0500
Message-ID: <CA+FuTSdJ+FiuSOaZ_i9STX_RmJAZRwg4MjZkcXPVu_YD0GsZ5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: add ipip6 and ip6ip decap
 to test_tc_tunnel
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 13, 2023 at 4:25 AM Ziyang Xuan
<william.xuanziyang@huawei.com> wrote:
>
> Add ipip6 and ip6ip decap testcases. Verify that bpf_skb_adjust_room()
> correctly decapsulate ipip6 and ip6ip tunnel packets.
>
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
