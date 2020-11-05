Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900D12A8A5E
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 00:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbgKEXE4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 18:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732086AbgKEXEz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 18:04:55 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9D8C0613CF
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 15:04:55 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id v144so4673819lfa.13
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 15:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4j2thf1GAZ1ka8io0eNzlpqFwwJDlIi2s7ciYBV0eU4=;
        b=WGZ1/WaGrUVgot/BDxPvFVceIUhUFt+D1WRaHJIQS9TYLG8jzDRegA7Y1XrgoLMcSj
         HPxRbIIrvTH2CVYrYfLbfplLZgE8zwk3iXdAo35yhqDyPl/jDObNpeJFADA/RFVTpWFk
         IKTfDUUtpoe+7LCUORJnp/GA7ZV6Qu30nVEdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4j2thf1GAZ1ka8io0eNzlpqFwwJDlIi2s7ciYBV0eU4=;
        b=eSoxlqzM6ZqF21tpVSyhVq1tLj1KfePJTqvjXUtK0/Jlpht0dA11sSutsx/dzjzo2e
         lIhkHuFsQERjdgBc6fUPXWLy8LkNABDkCp8/nmFV/t2ZfqqHHTDxP2DOOVpFMDXMqrxA
         hUPPCeZZBuvJVcF7KaGGBN74oCGJO7V/znmIkIkoNbIqdzWRmCV7/wQO5m+BeaqaOMnR
         e91FLojx453ZY/ERs0OTC7EuzRMa4xQFOd0ei2w0TJmg34rmlcaJnfTBiyBf5xQSDAN/
         KJ7CvAXqJT9oULBbbAb9+T5C/yuW6z+ZtT3kbJISmy90hF2rYVtOBhbT6dGZ7Wo1K5Uw
         nDBg==
X-Gm-Message-State: AOAM530smmpLrwUEomi3oiKywYeyv1pl6GtYVUdx5IxMP5ReRWVCPJKx
        4JNYCSesce+2XrriKoeZ7B8HwlTKRzkOpReAQGZo1w==
X-Google-Smtp-Source: ABdhPJxYbGXp9VC8uN2+teG2uD171oxhvM4AaLAf2mN7xswyTbanJNwbF5Bqna3uTqVrJXwaBRhX3kHPxcVj22xp5h4=
X-Received: by 2002:a05:6512:3102:: with SMTP id n2mr1801431lfb.153.1604617490774;
 Thu, 05 Nov 2020 15:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20201105230221.2620663-1-kpsingh@chromium.org>
In-Reply-To: <20201105230221.2620663-1-kpsingh@chromium.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 6 Nov 2020 00:04:39 +0100
Message-ID: <CACYkzJ7efr+riXRgwpL23L+o7_DZpqPk+PxP0eJQZHOU_MxoPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Update verification logic for LSM programs
To:     open list <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 6, 2020 at 12:02 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> The current logic checks if the name of the BTF type passed in
> attach_btf_id starts with "bpf_lsm_", this is not sufficient as it also
> allows attachment to non-LSM hooks like the very function that performs
> this check, i.e. bpf_lsm_verify_prog.
>
> In order to ensure that this verification logic allows attachment to
> only LSM hooks, the LSM_HOOK definitions in lsm_hook_defs.h are used to
> generate a BTD id set. The attach_btf_id of the program being attached

Fixing typo (BTD -> BTF) and resending.
