Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7371958B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2019 01:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEIXCL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 May 2019 19:02:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45857 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIXCK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 May 2019 19:02:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id n22so2726550lfe.12
        for <bpf@vger.kernel.org>; Thu, 09 May 2019 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUfZUkV7OUMLfK9LDrwBSfVXPyjgox+el+rIjKvEaVk=;
        b=vJKOefmb0lUct2BWhcpaygPRu/gK3gNRSKViwbmVrLV3KQw5XgRfov/nLml/r5/rWC
         kubyBpIYZscy8GT2npShx7PwpSC+BqCZNeK9KzkFZYiyzGHJ/IORi39qzoKO4q8i1MbU
         08APenHYAtUGYZTXHm10zAeTz3hs8TLtn2o8ijRO8IXTDO9C5Io0Pm1we/c9XLy2q0/o
         bvXqbWt2hGBdx7uDvyUMw2xmBV4KVFO7WxtdV15Arf9Ib+si80vwxfs5Wsx/upVe99C9
         M2I018NbwhNc5r5NQJieB/XkBqfOaRNV1vSZFBlPzLUXzDCJ5moyctQVVd8CMJNwnCuy
         50Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUfZUkV7OUMLfK9LDrwBSfVXPyjgox+el+rIjKvEaVk=;
        b=gzLrf5PFTz1mfMT3PNy2ymXZeBU0q0Yfc8F3oPha6rV655vMXd26wzYbocSatVN4Dh
         lgfhRy/ndzaf9GnegCLYYar65HRyU7enMuCV77f9Rc3BRt86TtDE7v7ks5bgncUNOoBy
         ld/ThWPT4FnR8NKgeSwVxfSh7fVxyqy5W+ubxB+OkZbTfSAxbZSFX17jwRVQtPh+g9OL
         kME4/lZnF/1nFp1qjUHqS2/tSLwQLMnjvZN/AJdLvLYuGK65181W9Zstg338GrgjLy1C
         wMR3IHPqspTk9ecKcU1NPTqsOlzf6IlAUzyjbkgy7AmrXtGbfQWgrAhlZqBGYnLpnAVO
         vdJg==
X-Gm-Message-State: APjAAAWlbxAoopk2QJdvOtG+uesiX6jdgOuzLXfbsHicI4ZLnabzpGHA
        ChgugikCAano/J78/orUrM7riRUTrlx9/N2pIlHLtg==
X-Google-Smtp-Source: APXvYqyUZ0HN3783nG76zl0rKcgpTmpTIIpL61iVbcFMoia21y0t4ojHJj/12En6m2QeypfSqjnCLO7CJRrsFFyvjcQ=
X-Received: by 2002:a19:8:: with SMTP id 8mr3899489lfa.125.1557442928733; Thu,
 09 May 2019 16:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190508075448.28477-1-glin@suse.com>
In-Reply-To: <20190508075448.28477-1-glin@suse.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 9 May 2019 16:01:57 -0700
Message-ID: <CAADnVQ+ovQAAXUZrYpyHmX=e2Zzo8-_bD4iUW+2Wj8dD2PYWSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/btf: fix the missing section marks
To:     Gary Lin <glin@suse.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 8, 2019 at 12:55 AM Gary Lin <glin@suse.com> wrote:
>
> The section titles of 3.4 and 3.5 are not marked correctly.
>
> Signed-off-by: Gary Lin <glin@suse.com>

Applied. Thanks
