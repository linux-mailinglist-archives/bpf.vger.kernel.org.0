Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C4240450C
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 07:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350764AbhIIFg6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 01:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350756AbhIIFg6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 01:36:58 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA0DC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 22:35:49 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id q70so1521627ybg.11
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 22:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3LxjugUgUxohvgs2u1ZsYc8sPiRILa7sdw70TsvpVIk=;
        b=bv7BWWl/dBA5a8yDbEQyR+cKActFMnXJq+HYJOKbFPRq6fljSk1xYI2+HiBRYQL/ki
         Pm3L0vCqkqmH3QcJXTdtn5rBSzAHhWUahKDNdpV5/CA+BErj/LtzMnLd1XozHj5AYA11
         /KUvyYape/REuvzK2Zpf2+XKzYrKVWEJdQLhIrqKDzgyhmgUzldRw3pQsLBk5jbql/rn
         8zNYROM7g+iTYuqVsHdQTEKnSgp0ocYY6W7OEzHHbU0FalkHuAjnVjvfTVHATIIIvdCu
         HAnyj4wZZoknXkqOzJaNfqc67ELNQW+f3eMZGfA8A38d5Vyk+YeHYomv/2n3HA85ErdM
         dASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LxjugUgUxohvgs2u1ZsYc8sPiRILa7sdw70TsvpVIk=;
        b=mMUMTryD56c4jUrj+bhbyhSZmgjd+pbVS4Orm3UObgTxTlCQaC6JMASOa5DeG6gXdR
         Eb9/0Gb7gHfyn6tJLA3CJ4ubxcv8I/yvno14HWty34wCLvqL5Yktfdl9b2B3F78OaN9F
         FnrtBT/jM+w+4N/noF57YLRSdWY0FoX0Z9+blVK+EDqZcOf2uWV8L7I+1R7GhSYSHDa1
         uKT9sIAQ3ox/RBRzZ1/AlPZgUsTYo9zbBEqa5uJeyOb2jZW/Ouus5xRVKBiHQOdZW7zT
         OxY5hFCMblCY21oGlkmlvqXgE5kgpTyakTMfe3gckUe90dP3YSlwqF4sso/t6AlQZOAI
         +HJg==
X-Gm-Message-State: AOAM5316Cyf+giBNtT1nme1k3TfEV43CFEjwLUAVympbzcvI/PKAQQ2t
        iu9seRRNRtdbF3Yzf7JFze17ev99LT8om7fqmlQ=
X-Google-Smtp-Source: ABdhPJy2eLsyPQOIEhiuQJRQxvhDjbG8QUMmVfcuCpq9J1LCcJeLtwMMYbxSPlLHzSiL2gPFCR5trOhB2VZO0Lx0z68=
X-Received: by 2002:a25:3604:: with SMTP id d4mr1491760yba.4.1631165748792;
 Wed, 08 Sep 2021 22:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210907230050.1957493-1-yhs@fb.com> <20210907230116.1959597-1-yhs@fb.com>
In-Reply-To: <20210907230116.1959597-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 22:35:37 -0700
Message-ID: <CAEf4Bzbyf3qnsypUF0CQNO16advVtZ=seVAthwoeN6PfQx8tWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/9] selftests/bpf: test libbpf API function btf__add_tag()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add btf_write tests with btf__add_tag() function.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/btf_helpers.c     |  7 +++++-
>  .../selftests/bpf/prog_tests/btf_write.c      | 23 +++++++++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
> index b692e6ead9b5..20dc8f4cb884 100644
> --- a/tools/testing/selftests/bpf/btf_helpers.c
> +++ b/tools/testing/selftests/bpf/btf_helpers.c
> @@ -24,11 +24,12 @@ static const char * const btf_kind_str_mapping[] = {
>         [BTF_KIND_VAR]          = "VAR",
>         [BTF_KIND_DATASEC]      = "DATASEC",
>         [BTF_KIND_FLOAT]        = "FLOAT",
> +       [BTF_KIND_TAG]          = "TAG",
>  };
>
>  static const char *btf_kind_str(__u16 kind)
>  {
> -       if (kind > BTF_KIND_DATASEC)
> +       if (kind > BTF_KIND_TAG)
>                 return "UNKNOWN";
>         return btf_kind_str_mapping[kind];
>  }
> @@ -177,6 +178,10 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
>         case BTF_KIND_FLOAT:
>                 fprintf(out, " size=%u", t->size);
>                 break;
> +       case BTF_KIND_TAG:
> +               fprintf(out, " type_id=%u, comp_id=%d",

seems like we use space as a separator, please remove comma for consistency

> +                       t->type, btf_kflag(t) ? -1 : (int)btf_tag(t)->comp_id);
> +               break;
>         default:
>                 break;
>         }

[...]
