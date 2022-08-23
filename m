Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8587459EF8B
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 01:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiHWXFV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 19:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiHWXFU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 19:05:20 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7367677
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 16:05:19 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j6so11467725qkl.10
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 16:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LnAdZv7r7lOsZ1cIzYaXYrepGm57cEHWd8kk0QXzNhU=;
        b=n47AXQB5T1zL1Hx+5JaKxpRkz1wrSC8OaeuEOSLjKnCALi6GAbQ2vQ5dtyEIUWlP8d
         AKyONmtDHv+o3mnWV7ssS2Og+6A12NjtDwGWFkJ65z2LA4fltSFo4bu1B+ohxFtVympc
         72Ltdyml3oJ5+oQO3WB+FSTY/TBr7IVKNKdJhOXt5Uh8HxFOq2w44BPz70UvWbw0DQxG
         5xT5yMpLrjuIgiu35A8bIswBHMGmKzMMhLAW1xmib7eFW9L6lw/td0Gqf/Fqc9yfe0N1
         CeiMy0+dqLUoZ2X5koSJT+VR7tOfL1Pg7/qRBz7bcoIue8kqanyQRZt+ArxZSbKDeTG8
         rolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LnAdZv7r7lOsZ1cIzYaXYrepGm57cEHWd8kk0QXzNhU=;
        b=QGbqXzzupjS0gPOUR6JQddQSZzu2WlplzD6kjdTZ3dw2F/xjGMAaq+lhRQEGjm83e6
         T18Xiqz/aXtiBrcgo+gBHBFO2I/2NIf7QhZCVCQcBJEEz/Pagg40IXXOeXSM/ah59+EX
         vQ891FTAzbi6Z1T5dP98cQAEtFmdSYC43wq4mofn042E5Dh4IEkVL+DXlrf7pxgdDaHd
         woKx4rQz5EqVw8qFXKG0diWWlq52eeREMepeqQizAdhLUTVHJTa5xdS3+yKtqXr7dVb/
         +Fv85T2XdqYmb6CDRAGeb9HEUXrAl88QZ+ELwLN0mJRkjDsCnv/hdgnO28vO45KPt7t/
         UDUw==
X-Gm-Message-State: ACgBeo2PFS/8Cg4L8PMEdxDDnBbNf6Df4bw1SPfPY6tXC1ihsnEZVH8s
        mAyR5BS0tPvP/PPXpOgAhnf6h640Iykp2gX2TkY=
X-Google-Smtp-Source: AA6agR7oLbw1ulRmM26gmwoimOlV8upOJb3Dr1GFiCkqHTO3VCGyqif3xHTeLQ/c8Ma9snPluQqr70I8nSKYdghWOlg=
X-Received: by 2002:a05:620a:c52:b0:6b5:467f:4f6d with SMTP id
 u18-20020a05620a0c5200b006b5467f4f6dmr18527526qki.503.1661295918340; Tue, 23
 Aug 2022 16:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220819091244.1001962-1-eyal.birger@gmail.com> <CACdoK4KY6W=CrBXGTBx=su7UZ6ryna2CsjNw=zeNWc_pXzkrrg@mail.gmail.com>
In-Reply-To: <CACdoK4KY6W=CrBXGTBx=su7UZ6ryna2CsjNw=zeNWc_pXzkrrg@mail.gmail.com>
From:   Eyal Birger <eyal.birger@gmail.com>
Date:   Wed, 24 Aug 2022 02:05:06 +0300
Message-ID: <CAHsH6GsTuWKyRtira6jG7jfqh4VOwKh1oYkkGt=8w2u4rQJByA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/scripts: use helper enum value instead of
 relying on comment order
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Quentin,

On Tue, Aug 23, 2022 at 11:49 PM Quentin Monnet <quentin@isovalent.com> wrote:
>
> On Fri, 19 Aug 2022 at 10:13, Eyal Birger <eyal.birger@gmail.com> wrote:
> >
> > The helper value is ABI as defined by enum bpf_func_id.
> > As bpf_helper_defs.h is used for the userpace part, it must be consistent
> > with this enum.
> >
> > Before this change, the enumerated value was derived from the comment
> > order, which assumes comments are always appended, however, there doesn't
> > seem to be an enforcement anywhere for maintaining a strict order.
> >
> > When adding new helpers it is very puzzling when the userspace application
> > breaks in weird places if the comment is inserted instead of appended -
> > because the generated helper ABI is incorrect and shifted.
> >
> > This commit attempts to ease this by always using bpf_func_id order as
> > the helper value.
> >
> > Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> > ---
> >  scripts/bpf_doc.py | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> > index dfb260de17a8..7797aa032eca 100755
> > --- a/scripts/bpf_doc.py
> > +++ b/scripts/bpf_doc.py
> > @@ -88,7 +88,7 @@ class HeaderParser(object):
> >          self.helpers = []
> >          self.commands = []
> >          self.desc_unique_helpers = set()
> > -        self.define_unique_helpers = []
> > +        self.define_unique_helpers = {}
> >          self.desc_syscalls = []
> >          self.enum_syscalls = []
> >
> > @@ -245,24 +245,24 @@ class HeaderParser(object):
> >                  break
> >
> >      def parse_define_helpers(self):
> > -        # Parse the number of FN(...) in #define __BPF_FUNC_MAPPER to compare
> > -        # later with the number of unique function names present in description.
> > +        # Parse FN(...) in #define __BPF_FUNC_MAPPER to compare later with the
> > +        # number of unique function names present in description and use the
> > +        # correct enumeration value.
> >          # Note: seek_to(..) discards the first line below the target search text,
> >          # resulting in FN(unspec) being skipped and not added to self.define_unique_helpers.
> >          self.seek_to('#define __BPF_FUNC_MAPPER(FN)',
> >                       'Could not find start of eBPF helper definition list')
> >          # Searches for either one or more FN(\w+) defines or a backslash for newline
> > -        p = re.compile('\s*(FN\(\w+\))+|\\\\')
> > -        fn_defines_str = ''
> > +        p = re.compile('\s*FN\((\w+)\)+|\\\\')
>
> Nit: I think the second '+' should be removed, I don't think you can
> have consecutive "FN(...)" without at least a comma. But you didn't
> add and it is harmless, so it can be a follow-up or wait until a
> future clean-up.
>

Sure. I can remove that.

> > +        i = 1  # 'unspec' is skipped as mentioned above
> >          while True:
> >              capture = p.match(self.line)
> >              if capture:
> > -                fn_defines_str += self.line
> > +                self.define_unique_helpers[capture.expand(r'bpf_\1')] = i
> > +                i += 1
> >              else:
> >                  break
> >              self.line = self.reader.readline()
> > -        # Find the number of occurences of FN(\w+)
> > -        self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
> >
> >      def run(self):
> >          self.parse_desc_syscall()
> > @@ -573,6 +573,7 @@ class PrinterHelpers(Printer):
> >      def __init__(self, parser):
> >          self.elements = parser.helpers
> >          self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '__BPF_FUNC_MAPPER')
> > +        self.define_unique_helpers = parser.define_unique_helpers
> >
> >      type_fwds = [
> >              'struct bpf_fib_lookup',
> > @@ -761,7 +762,7 @@ class PrinterHelpers(Printer):
> >              comma = ', '
> >              print(one_arg, end='')
> >
> > -        print(') = (void *) %d;' % len(self.seen_helpers))
> > +        print(') = (void *) %d;' % self.define_unique_helpers[proto['name']])
> >          print('')
>
> The code seems correct and should make the script more robust, and I
> checked that the man page and header file are generated identically.
>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks for the review.

>
> However, I would recommend against inserting the description of new
> helpers in the middle of the current documentation. Having the helpers
> listed in order of creation is maybe not ideal, but at least they are
> ordered, and the list remains consistent with the items of enum
> bpf_func_id. I'm not opposed to reworking the list to have them
> displayed in a more logical order, but in that case I think we should
> reorganise the whole list, not just start inserting new descriptions
> in the middle.
>

I understand. Personally I don't mind the fact that they're ordered
relative to their enum value, only that this is implicitly enforced.

Since we know both the enum value and the comment value, would it be
acceptible to add an assertion here so that at least wrongful insertions
break the file generation instead of skewing the values?

Eyal.

> Thanks,
> Quentin
