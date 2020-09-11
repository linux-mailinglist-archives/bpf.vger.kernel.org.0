Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DEE265E5D
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 12:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgIKKw2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 06:52:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59239 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725835AbgIKKwZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 06:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599821542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jHRtuARY5xx6Zy98e3+O2VSg03hcSksfEHlzR8SEmwI=;
        b=dUtc+F50qOhC0mFBXrzX1Co1pCiJpVzL6nA1v/cKyxmi+r9XeXTIwIFG/Lex0hmJWohP3K
        Gc0qxwGzGGxBq8yJiqaX3+vqrhQSoArnSQ0Jdi3+nfytlvSNZJi8wLaGObZaErq7v1jwFY
        GtQ9FtQGtTarHBcjfqRE2zhBIzGK8TE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-BBKYxH2bNX2r0QGZRrGZdg-1; Fri, 11 Sep 2020 06:52:21 -0400
X-MC-Unique: BBKYxH2bNX2r0QGZRrGZdg-1
Received: by mail-wr1-f71.google.com with SMTP id l15so3369672wro.10
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 03:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jHRtuARY5xx6Zy98e3+O2VSg03hcSksfEHlzR8SEmwI=;
        b=FjoJVwvEuH6RQmDDLWVIbnu8pv0ZZA/l4uJrSxfJI5qFVRzAeyuMWp2V92QwGFGZky
         qM0cUrEIEG4kE49im/izmJBpY9kPkS4sKftpFJc+KYyQRYQrumaHhC701KG1yt3knjs/
         PqNSwYqYCXnFHCC/6YoFGtqawbQ3svZJV7TWv4oRfueue/lO8jyq4apr9eLT3IHWRRm7
         vH2uMge2HS4VU5bB8emwRE++3IY+HUqImxiQPM+okv+3EjA6gFb2+veXos1COgePUrZG
         eEQjt2+1B5F3FgGGHH+iJirPpChQopsiCzHu9i+K1IL5RwkETNA+t9z8bPQg6CE/iBLO
         VQbw==
X-Gm-Message-State: AOAM530rtwBWF9tYiJj5Rk+B2riCoXUWQGToaFN/lJqrGnKL/8R0oERg
        p63q7t0JEkxdL6/iWFXZf02dKA043JVITw9grlYWpKhkuiIUwnTZ5Nhm5zLTSASUduUJ2BJb+oJ
        k9tI7PDF8It88
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr1598936wml.121.1599821540087;
        Fri, 11 Sep 2020 03:52:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp9uoo30gaLk4Sxob/TvZRYrTy45Lu6qbRVTyt1j2VLxqIlMWDyqrfaslZWCCi+1zHfh3dtQ==
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr1598909wml.121.1599821539588;
        Fri, 11 Sep 2020 03:52:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l16sm4115533wrb.70.2020.09.11.03.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 03:52:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 838341829D4; Fri, 11 Sep 2020 12:52:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eelco Chaudron <echaudro@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix context type resolving for
 extension programs
In-Reply-To: <CAADnVQ+3sBR7dTQhX+eHvzJajtnm0QctjrWFyc+LMkHJOoOabA@mail.gmail.com>
References: <20200909151115.1559418-1-jolsa@kernel.org>
 <CAADnVQ+3sBR7dTQhX+eHvzJajtnm0QctjrWFyc+LMkHJOoOabA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Sep 2020 12:52:17 +0200
Message-ID: <871rj8bn6m.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Sep 9, 2020 at 8:11 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>
>> Eelco reported we can't properly access arguments if the tracing
>> program is attached to extension program.
>>
>> Having following program:
>>
>>   SEC("classifier/test_pkt_md_access")
>>   int test_pkt_md_access(struct __sk_buff *skb)
>>
>> with its extension:
>>
>>   SEC("freplace/test_pkt_md_access")
>>   int test_pkt_md_access_new(struct __sk_buff *skb)
>>
>> and tracing that extension with:
>>
>>   SEC("fentry/test_pkt_md_access_new")
>>   int BPF_PROG(fentry, struct sk_buff *skb)
>>
>> It's not possible to access skb argument in the fentry program,
>> with following error from verifier:
>>
>>   ; int BPF_PROG(fentry, struct sk_buff *skb)
>>   0: (79) r1 = *(u64 *)(r1 +0)
>>   invalid bpf_context access off=0 size=8
>>
>> The problem is that btf_ctx_access gets the context type for the
>> traced program, which is in this case the extension.
>>
>> But when we trace extension program, we want to get the context
>> type of the program that the extension is attached to, so we can
>> access the argument properly in the trace program.
>>
>> Reported-by: Eelco Chaudron <echaudro@redhat.com>
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>> ---
>>  kernel/bpf/btf.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index f9ac6935ab3c..37ad01c32e5a 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -3859,6 +3859,14 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>>         }
>>
>>         info->reg_type = PTR_TO_BTF_ID;
>> +
>> +       /* When we trace extension program, we want to get the context
>> +        * type of the program that the extension is attached to, so
>> +        * we can access the argument properly in the trace program.
>> +        */
>> +       if (tgt_prog && tgt_prog->type == BPF_PROG_TYPE_EXT)
>> +               tgt_prog = tgt_prog->aux->linked_prog;
>> +
>>         if (tgt_prog) {
>>                 ret = btf_translate_to_vmlinux(log, btf, t, tgt_prog->type, arg);
>
> I think it would be cleaner to move resolve_prog_type() from verifier.c
> and use that helper function here.

FYI, I've added a different version of this patch to my freplace
multi-attach series (since the approach here was incompatible with
that).

-Toke

