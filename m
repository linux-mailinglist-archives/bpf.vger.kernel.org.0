Return-Path: <bpf+bounces-8317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A311784D55
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 01:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B3B1C20B6C
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356A220EFC;
	Tue, 22 Aug 2023 23:31:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E120EE0;
	Tue, 22 Aug 2023 23:31:10 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B4DCF;
	Tue, 22 Aug 2023 16:31:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ff882397ecso7683334e87.3;
        Tue, 22 Aug 2023 16:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692747067; x=1693351867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiVsbcQ1calg/mgIA/8p2AIsEEXhjJvmCX/Nb9G73+8=;
        b=QGEBDW107RW9l0/oBgV0fIpwlZiidK/GJ7fTcsTcyzsiWdxUKW/j+/2mJY4aLK+PsG
         31/9BinUD/PkkbOa/OBwvY614Bm81qEXzJY3Ktmp9sGPFyGfPNx4sPESHn4cEzo/VXoc
         NbPUmjHMhyn+iHypuKkFMzim46ZQ6WCwotueLhhsSKLmc5GHuEfjJrPnFftU+AdHmiED
         daAWEdtKEY9tzYTAsUVFnZ1iZSWUGjDXw9kG+ckgxDzczTmtMv5EfDtgcW0wliaIK+eK
         za3EKe0Ssn/Fg6jS2OrbzzuZNuPu8i8rBZUU2epJ1/LSY8aDuvYa3bNte+K+/9kdOTbw
         +z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692747067; x=1693351867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiVsbcQ1calg/mgIA/8p2AIsEEXhjJvmCX/Nb9G73+8=;
        b=QvpsAV9VbpDclq51w1zP5zyXl0dzH+wrC7jdwQZsrkN7BbBmPYuaDV0u6ICICaKrh0
         87Tvv3T9h/CtORxKhRdKtrIGetstk2HwHk6v0s9l4b4RJU1jdPng9BCMznSm7dhLbem1
         RhWc4iwgKCI1WpPpGgbHgX9lNTtkgGAUmsko7r0UVtc6u4GRryR3JuARZ6+XzENxYO/0
         sWZXrrztG+a5YGmbpvJCgxafPzPSUUuPwC4yXKRaB7HX6XTQ7Bdjfh5Yrd5DOj+vbsxA
         SPlTWrbyMXBpHCQ8H5eDI7Vlj/PXG970Gf1ua/NVGNIUtZp+ZXfw06Nn99GrPhtWhSjz
         mNzg==
X-Gm-Message-State: AOJu0YwxMXxGBhZaAj97h9kt03V7SPmIen6Bscc21tqU9tGV84bkh+7O
	fSA1AixcpH6ouQRS6agWTyOVER7Sn/4DgnRF8beHCGkQ
X-Google-Smtp-Source: AGHT+IHlEgG9P/8QbyLaWdXEtuE/H/EjLYnQCkm8HRBhtVJb/u+ifdl1gIhardVeS5xH9Ahx7bTyLyO9W4osu7Az32U=
X-Received: by 2002:a05:6512:3189:b0:4f7:6453:f3f1 with SMTP id
 i9-20020a056512318900b004f76453f3f1mr10156407lfe.15.1692747066558; Tue, 22
 Aug 2023 16:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811084739.GY3902@linux.vnet.ibm.com> <20230816122133.1231599-1-vishalc@linux.ibm.com>
In-Reply-To: <20230816122133.1231599-1-vishalc@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Aug 2023 16:30:54 -0700
Message-ID: <CAEf4BzZeCzEUM+=D7F5vNAe3fgmbGf0qo_DQ1nKSUJ-G78iFyw@mail.gmail.com>
Subject: Re: [PATCH] Fix invalid escape sequence warnings
To: Vishal Chourasia <vishalc@linux.ibm.com>, Quentin Monnet <quentin@isovalent.com>
Cc: srikar@linux.vnet.ibm.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sachinp@linux.ibm.com, sdf@google.com, song@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 5:22=E2=80=AFAM Vishal Chourasia <vishalc@linux.ibm=
.com> wrote:
>
> The Python script `bpf_doc.py` uses regular expressions with
> backslashes in string literals, which results in SyntaxWarnings
> during its execution.
>
> This patch addresses these warnings by converting relevant string
> literals to raw strings, which interpret backslashes as literal
> characters. This ensures that the regular expressions are parsed
> correctly without causing any warnings.
>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>
> ---
>  scripts/bpf_doc.py | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index eaae2ce78381..dfd819c952b2 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -59,9 +59,9 @@ class Helper(APIElement):
>          Break down helper function protocol into smaller chunks: return =
type,
>          name, distincts arguments.
>          """
> -        arg_re =3D re.compile('((\w+ )*?(\w+|...))( (\**)(\w+))?$')
> +        arg_re =3D re.compile(r'((\w+ )*?(\w+|...))( (\**)(\w+))?$')
>          res =3D {}
> -        proto_re =3D re.compile('(.+) (\**)(\w+)\(((([^,]+)(, )?){1,5})\=
)$')
> +        proto_re =3D re.compile(r'(.+) (\**)(\w+)\(((([^,]+)(, )?){1,5})=
\)$')
>
>          capture =3D proto_re.match(self.proto)
>          res['ret_type'] =3D capture.group(1)
> @@ -114,11 +114,11 @@ class HeaderParser(object):
>          return Helper(proto=3Dproto, desc=3Ddesc, ret=3Dret)
>
>      def parse_symbol(self):
> -        p =3D re.compile(' \* ?(BPF\w+)$')
> +        p =3D re.compile(r' \* ?(BPF\w+)$')
>          capture =3D p.match(self.line)
>          if not capture:
>              raise NoSyscallCommandFound
> -        end_re =3D re.compile(' \* ?NOTES$')
> +        end_re =3D re.compile(r' \* ?NOTES$')
>          end =3D end_re.match(self.line)
>          if end:
>              raise NoSyscallCommandFound
> @@ -133,7 +133,7 @@ class HeaderParser(object):
>          #   - Same as above, with "const" and/or "struct" in front of ty=
pe
>          #   - "..." (undefined number of arguments, for bpf_trace_printk=
())
>          # There is at least one term ("void"), and at most five argument=
s.
> -        p =3D re.compile(' \* ?((.+) \**\w+\((((const )?(struct )?(\w+|\=
.\.\.)( \**\w+)?)(, )?){1,5}\))$')
> +        p =3D re.compile(r' \* ?((.+) \**\w+\((((const )?(struct )?(\w+|=
\.\.\.)( \**\w+)?)(, )?){1,5}\))$')
>          capture =3D p.match(self.line)
>          if not capture:
>              raise NoHelperFound
> @@ -141,7 +141,7 @@ class HeaderParser(object):
>          return capture.group(1)
>
>      def parse_desc(self, proto):
> -        p =3D re.compile(' \* ?(?:\t| {5,8})Description$')
> +        p =3D re.compile(r' \* ?(?:\t| {5,8})Description$')
>          capture =3D p.match(self.line)
>          if not capture:
>              raise Exception("No description section found for " + proto)
> @@ -154,7 +154,7 @@ class HeaderParser(object):
>              if self.line =3D=3D ' *\n':
>                  desc +=3D '\n'
>              else:
> -                p =3D re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
> +                p =3D re.compile(r' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
>                  capture =3D p.match(self.line)
>                  if capture:
>                      desc_present =3D True
> @@ -167,7 +167,7 @@ class HeaderParser(object):
>          return desc
>
>      def parse_ret(self, proto):
> -        p =3D re.compile(' \* ?(?:\t| {5,8})Return$')
> +        p =3D re.compile(r' \* ?(?:\t| {5,8})Return$')
>          capture =3D p.match(self.line)
>          if not capture:
>              raise Exception("No return section found for " + proto)
> @@ -180,7 +180,7 @@ class HeaderParser(object):
>              if self.line =3D=3D ' *\n':
>                  ret +=3D '\n'
>              else:
> -                p =3D re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
> +                p =3D re.compile(r' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
>                  capture =3D p.match(self.line)
>                  if capture:
>                      ret_present =3D True
> @@ -219,12 +219,12 @@ class HeaderParser(object):
>          self.seek_to('enum bpf_cmd {',
>                       'Could not find start of bpf_cmd enum', 0)
>          # Searches for either one or more BPF\w+ enums
> -        bpf_p =3D re.compile('\s*(BPF\w+)+')
> +        bpf_p =3D re.compile(r'\s*(BPF\w+)+')
>          # Searches for an enum entry assigned to another entry,
>          # for e.g. BPF_PROG_RUN =3D BPF_PROG_TEST_RUN, which is
>          # not documented hence should be skipped in check to
>          # determine if the right number of syscalls are documented
> -        assign_p =3D re.compile('\s*(BPF\w+)\s*=3D\s*(BPF\w+)')
> +        assign_p =3D re.compile(r'\s*(BPF\w+)\s*=3D\s*(BPF\w+)')
>          bpf_cmd_str =3D ''
>          while True:
>              capture =3D assign_p.match(self.line)
> @@ -239,7 +239,7 @@ class HeaderParser(object):
>                  break
>              self.line =3D self.reader.readline()
>          # Find the number of occurences of BPF\w+
> -        self.enum_syscalls =3D re.findall('(BPF\w+)+', bpf_cmd_str)
> +        self.enum_syscalls =3D re.findall(r'(BPF\w+)+', bpf_cmd_str)
>
>      def parse_desc_helpers(self):
>          self.seek_to(helpersDocStart,
> @@ -263,7 +263,7 @@ class HeaderParser(object):
>          self.seek_to('#define ___BPF_FUNC_MAPPER(FN, ctx...)',
>                       'Could not find start of eBPF helper definition lis=
t')
>          # Searches for one FN(\w+) define or a backslash for newline
> -        p =3D re.compile('\s*FN\((\w+), (\d+), ##ctx\)|\\\\')
> +        p =3D re.compile(r'\s*FN\((\w+), (\d+), ##ctx\)|\\\\')
>          fn_defines_str =3D ''
>          i =3D 0
>          while True:
> @@ -278,7 +278,7 @@ class HeaderParser(object):
>                  break
>              self.line =3D self.reader.readline()
>          # Find the number of occurences of FN(\w+)
> -        self.define_unique_helpers =3D re.findall('FN\(\w+, \d+, ##ctx\)=
', fn_defines_str)
> +        self.define_unique_helpers =3D re.findall(r'FN\(\w+, \d+, ##ctx\=
)', fn_defines_str)
>
>      def validate_helpers(self):
>          last_helper =3D ''
> @@ -425,7 +425,7 @@ class PrinterRST(Printer):
>          try:
>              cmd =3D ['git', 'log', '-1', '--pretty=3Dformat:%cs', '--no-=
patch',
>                     '-L',
> -                   '/{}/,/\*\//:include/uapi/linux/bpf.h'.format(delimit=
er)]
> +                   r'/{}/,/\*\//:include/uapi/linux/bpf.h'.format(delimi=
ter)]

this one is not a regex, do we still need to change it?

>              date =3D subprocess.run(cmd, cwd=3DlinuxRoot,
>                                    capture_output=3DTrue, check=3DTrue)
>              return date.stdout.decode().rstrip()
> @@ -496,7 +496,7 @@ HELPERS
>                              date=3DlastUpdate))
>
>      def print_footer(self):
> -        footer =3D '''
> +        footer =3D r'''

same here, not a regex string

>  EXAMPLES
>  =3D=3D=3D=3D=3D=3D=3D=3D
>
> @@ -598,7 +598,7 @@ SEE ALSO
>              one_arg =3D '{}{}'.format(comma, a['type'])
>              if a['name']:
>                  if a['star']:
> -                    one_arg +=3D ' {}**\ '.format(a['star'].replace('*',=
 '\\*'))
> +                    one_arg +=3D r' {}**\ '.format(a['star'].replace('*'=
, '\\*'))

and this one as well?

>                  else:
>                      one_arg +=3D '** '
>                  one_arg +=3D '*{}*\\ **'.format(a['name'])
> --
> 2.41.0
>

