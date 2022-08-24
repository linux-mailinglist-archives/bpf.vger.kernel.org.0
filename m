Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E360859F5DD
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiHXJES (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 05:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiHXJER (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 05:04:17 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CA07E01F
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 02:04:16 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g21so12180224qka.5
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tZLOll+6NKwBtC5FLccrsfmkv5x1ZPCzLnaLer+5tUM=;
        b=Sm72rg5H0q0KiI92HbNv2p3a6vVjalb57tzloY8Seyz6PaZVDcxWX3VsosYC1Bg96U
         CCVwqBtDOK4OEc3aVbUuFdwULxRhkFzdbLnV7G8Be6XlG4G7Vind82PXnHb9WRfPReqo
         +xUvrQJ2JaDnq8yQEj7wlD+eJWR42uwg5kQVV8StOc+6hIlNgmrfFlryppMuIufso+HA
         yufunjfoLvLV2PQWX8gJMtod4UXYR19ZESfPT0tR2nXKRxY54ksBjLUHO/g3McmAfbaG
         KSvA902GPw/jEi66qQ8/SoXqcI8gM58cLXa9qiYIJvtEamReCBUpxC2J5l1o6evHFpw7
         FqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tZLOll+6NKwBtC5FLccrsfmkv5x1ZPCzLnaLer+5tUM=;
        b=Ez+M9MqbomcXs18DBa1uYyCmNhT5fwe3AfkZ6yW8SXjnaPDGHmTQvXbsXv5D08AeX/
         GBwd8h+OYdu+uP3mKX5bXBXK7PKvOGLFaJDzDVNupCxn+v11sPEATXP5VMystzs9mH0A
         P5+Qs4i9ebnoHSiLWotboYoYKgfE99W/y94RzQTU+1FCDbtySW3nwIDeX0FL+hARHcFm
         r5L9T8p+uQJxBYbV5gRWLeSOTzFttiBaDs+0y+DMtH7Tp6kjFOl41e7sf1YnymWKnQOF
         BEWen4YzeGkvg/6ZAOdYu63XikijYaCUcvHva2+n+9dDbQ29mp199MxgGPBgEX4mnJJD
         u23w==
X-Gm-Message-State: ACgBeo1WM9mEUhHKEETjPHSBgQd30QmRTG55hvgRYiUIVIqQ7aKakM8i
        fVzOH5lxQ80q7lBwoSg6l84IiR9XNUMVLYV70e0=
X-Google-Smtp-Source: AA6agR7Cx+mQQm5C9mQNQtS/9GeE31/KdQ5juRiPVKEpkaD0XVHrAj7L5deL+Jhl4nAqmzR/xc9g3SUT+BmoiK0VoBM=
X-Received: by 2002:ae9:ed0a:0:b0:6ba:d20b:1002 with SMTP id
 c10-20020ae9ed0a000000b006bad20b1002mr19043591qkg.30.1661331855815; Wed, 24
 Aug 2022 02:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220819091244.1001962-1-eyal.birger@gmail.com>
 <CACdoK4KY6W=CrBXGTBx=su7UZ6ryna2CsjNw=zeNWc_pXzkrrg@mail.gmail.com>
 <CAHsH6GsTuWKyRtira6jG7jfqh4VOwKh1oYkkGt=8w2u4rQJByA@mail.gmail.com> <53cd19db-3b51-2d7f-1968-c67027d28db9@isovalent.com>
In-Reply-To: <53cd19db-3b51-2d7f-1968-c67027d28db9@isovalent.com>
From:   Eyal Birger <eyal.birger@gmail.com>
Date:   Wed, 24 Aug 2022 12:04:04 +0300
Message-ID: <CAHsH6GtbKTQ79=ghyP_2YriQWS26JHLtTOwOE_A2X3LTfxHxow@mail.gmail.com>
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

On Wed, Aug 24, 2022 at 11:44 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> On 24/08/2022 00:05, Eyal Birger wrote:
> > Hi Quentin,
> >
> > On Tue, Aug 23, 2022 at 11:49 PM Quentin Monnet <quentin@isovalent.com> wrote:
> >>
> >> On Fri, 19 Aug 2022 at 10:13, Eyal Birger <eyal.birger@gmail.com> wrote:
> >>>
> >>> The helper value is ABI as defined by enum bpf_func_id.
> >>> As bpf_helper_defs.h is used for the userpace part, it must be consistent
> >>> with this enum.
> >>>
> >>> Before this change, the enumerated value was derived from the comment
> >>> order, which assumes comments are always appended, however, there doesn't
> >>> seem to be an enforcement anywhere for maintaining a strict order.
> >>>
> >>> When adding new helpers it is very puzzling when the userspace application
> >>> breaks in weird places if the comment is inserted instead of appended -
> >>> because the generated helper ABI is incorrect and shifted.
> >>>
> >>> This commit attempts to ease this by always using bpf_func_id order as
> >>> the helper value.
> >>>
> >>> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> >>> ---
> >>>  scripts/bpf_doc.py | 19 ++++++++++---------
> >>>  1 file changed, 10 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> >>> index dfb260de17a8..7797aa032eca 100755
> >>> --- a/scripts/bpf_doc.py
> >>> +++ b/scripts/bpf_doc.py
> >>> @@ -88,7 +88,7 @@ class HeaderParser(object):
> >>>          self.helpers = []
> >>>          self.commands = []
> >>>          self.desc_unique_helpers = set()
> >>> -        self.define_unique_helpers = []
> >>> +        self.define_unique_helpers = {}
> >>>          self.desc_syscalls = []
> >>>          self.enum_syscalls = []
> >>>
> >>> @@ -245,24 +245,24 @@ class HeaderParser(object):
> >>>                  break
> >>>
> >>>      def parse_define_helpers(self):
> >>> -        # Parse the number of FN(...) in #define __BPF_FUNC_MAPPER to compare
> >>> -        # later with the number of unique function names present in description.
> >>> +        # Parse FN(...) in #define __BPF_FUNC_MAPPER to compare later with the
> >>> +        # number of unique function names present in description and use the
> >>> +        # correct enumeration value.
> >>>          # Note: seek_to(..) discards the first line below the target search text,
> >>>          # resulting in FN(unspec) being skipped and not added to self.define_unique_helpers.
> >>>          self.seek_to('#define __BPF_FUNC_MAPPER(FN)',
> >>>                       'Could not find start of eBPF helper definition list')
> >>>          # Searches for either one or more FN(\w+) defines or a backslash for newline
> >>> -        p = re.compile('\s*(FN\(\w+\))+|\\\\')
> >>> -        fn_defines_str = ''
> >>> +        p = re.compile('\s*FN\((\w+)\)+|\\\\')
> >>
> >> Nit: I think the second '+' should be removed, I don't think you can
> >> have consecutive "FN(...)" without at least a comma. But you didn't
> >> add and it is harmless, so it can be a follow-up or wait until a
> >> future clean-up.
> >>
> >
> > Sure. I can remove that.
> >
> >>> +        i = 1  # 'unspec' is skipped as mentioned above
> >>>          while True:
> >>>              capture = p.match(self.line)
> >>>              if capture:
> >>> -                fn_defines_str += self.line
> >>> +                self.define_unique_helpers[capture.expand(r'bpf_\1')] = i
> >>> +                i += 1
> >>>              else:
> >>>                  break
> >>>              self.line = self.reader.readline()
> >>> -        # Find the number of occurences of FN(\w+)
> >>> -        self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
> >>>
> >>>      def run(self):
> >>>          self.parse_desc_syscall()
> >>> @@ -573,6 +573,7 @@ class PrinterHelpers(Printer):
> >>>      def __init__(self, parser):
> >>>          self.elements = parser.helpers
> >>>          self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '__BPF_FUNC_MAPPER')
> >>> +        self.define_unique_helpers = parser.define_unique_helpers
> >>>
> >>>      type_fwds = [
> >>>              'struct bpf_fib_lookup',
> >>> @@ -761,7 +762,7 @@ class PrinterHelpers(Printer):
> >>>              comma = ', '
> >>>              print(one_arg, end='')
> >>>
> >>> -        print(') = (void *) %d;' % len(self.seen_helpers))
> >>> +        print(') = (void *) %d;' % self.define_unique_helpers[proto['name']])
> >>>          print('')
> >>
> >> The code seems correct and should make the script more robust, and I
> >> checked that the man page and header file are generated identically.
> >>
> >> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> >
> > Thanks for the review.
> >
> >>
> >> However, I would recommend against inserting the description of new
> >> helpers in the middle of the current documentation. Having the helpers
> >> listed in order of creation is maybe not ideal, but at least they are
> >> ordered, and the list remains consistent with the items of enum
> >> bpf_func_id. I'm not opposed to reworking the list to have them
> >> displayed in a more logical order, but in that case I think we should
> >> reorganise the whole list, not just start inserting new descriptions
> >> in the middle.
> >>
> >
> > I understand. Personally I don't mind the fact that they're ordered
> > relative to their enum value, only that this is implicitly enforced.
> >
> > Since we know both the enum value and the comment value, would it be
> > acceptible to add an assertion here so that at least wrongful insertions
> > break the file generation instead of skewing the values?
>
> As I understand it, your patch already solves the issue by making sure
> we use the correct value even if the descriptions do not come in the
> same order as the enum items. Do you mean adding an additional check to
> enforce that the description items are in the same order, in addition to
> your patch?
>

Yes. The patch would fetch the value from the enum, but also assert that
the enum value is the same as the comment order value.


> I don't have a strong opinion, if anything I'd say it's probably not the
> role of this script to ensure that the description items are in a
> particular order (provided your patch is applied and the values are
> correct). I'm not sure we want to strongly enforce the order; I would
> definitely recommend against inserting new items in the middle, but at
> the same time I wouldn't oppose some reorganisation into logical
> sections. On the other hand, it's probably cleaner to have the
> definitions in the generated header file listed in the correct order of
> the enum values, so why not having the assertion for now, and lifting it
> if we ever want to rework the order.
>
I agree. I think for now we can have the assertion, and lift it when
a reorganization of the comments is done. I'll send a v2.


> Quentin
