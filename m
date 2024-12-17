Return-Path: <bpf+bounces-47110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266C29F459F
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 09:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7AD188C3E0
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 08:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FCA1D5179;
	Tue, 17 Dec 2024 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7/OfnB5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCDF145B39;
	Tue, 17 Dec 2024 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422576; cv=none; b=DfRxor+pvx3wFkfuzvrPT300DqjytS0KaSeYN/8G/yQCyHNGezoPZIHWanyNJbTTafSc6gyfdL4PbvqipO79ZFPjiTONibeXNOAKOwdAKtoKup8KwiJttBX6d7GpvkJWzrqt5luZ1WkHhDQIykkLVvcM9URjybUuT9Qk9dT6kLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422576; c=relaxed/simple;
	bh=9Hp6gBaZltBdCJpha2XOW2+2tQX3NfSz4GmobUXmJL0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ug2DnfzXCKlgZBKQI1pGOUITHC5XvajfSZHqD9LFFiqqg6KZaMd99fAgtC9NDGQqXl7D5SNFYXe98Nf17Y4wyHTT3+zKC8BsnswIDia2jmg70W58E9ccyiJcC362iRuGRw8adKekriLkrzSyQ+7rEvNWuBZCFV/DLrYf9euYPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7/OfnB5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so672890566b.1;
        Tue, 17 Dec 2024 00:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734422572; x=1735027372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I8KYznOvQ9Ns7fS2EG3QX401236xaX+oyKJLcRk8+uE=;
        b=V7/OfnB5fAFUyy20fEV3itHWCGeYd7aZi0PQfv1acm73a1nA77qeqSA/EHvRsGvGpV
         7TppkkZ0fCwrSk07ONfwe9v4p9XYjzF5r7rteGvMKkaKqNepe63Oaqs6uu71cUczHA5f
         K0El6JhFQzqSvwgtB3riHkEdQcU89kzqsJY0hf7Hs7NaQigULrDRWVdyzjQr1T/6bJ5I
         5dM9/zXmCAhEBQ48HUiAbZFo5c/lzKWSgW9kAzrdQvdXZBdUZhY462HtuERxZRdKexDH
         jWeKsCzCY+qUodRnR+KRkJCCPBNXnioA+OYGMJdxCRskXe1azHm157KcX4h6FuoTk0AY
         oTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734422572; x=1735027372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8KYznOvQ9Ns7fS2EG3QX401236xaX+oyKJLcRk8+uE=;
        b=Teo/HIIueAHbBUoBT0+BrfUznxhDvAMylpceSobrZYFqNt3Fomz/zt0OiEdNITjrj+
         l2X/2fuPmGAZdvClWBpHaizYeEOSMEL439xVqUWKhfXdy9ozS9enWcALNRUvD2s1gxVB
         U1HcNLaiyhTRVSGdtwNRsMm2mxmKwOFug9YADti7q+6UjLdPCXwmTSGJZYzichf99DFu
         2j1GE8JZXpYcGtsfxCFYozS1I9D/8CwETkT7i7ZCO4uWPAT5LNG4/gBBZxcOTRVr/vLP
         UN6z9pFovIyR7DJko+WewR1i4kMss/Gvx9lwtsE2UliB1lb8hN5Tfo6Yz4sgml5SEuvR
         cQag==
X-Forwarded-Encrypted: i=1; AJvYcCUcO5aSCdeIE9etKdpSXpofvult0F+eEmUOQt/5icP/xwAFzGLVo7O6FrP50E4TaIGg2w0=@vger.kernel.org, AJvYcCWryiXvB/Iq4JHcDEsFkTK9iw9yUiGm4gkmdDnwZV2J5nZpf/Y9Sk8bHupA6Sgm77njLs5fGeqy3Td/5T78@vger.kernel.org, AJvYcCXp9hZYowP7b+G6uKOSQYjsJ8nwfS6ow+8UhN0km345GrGiA5af7Ou+VSnAudBySrwGaBFNBJ0eGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZBrTMdSHlnANa7xCeNucpBm60znbB5A2t5xZzOwm677gjuSDU
	mwlQ8mfKLRLU9v7fjdoyD4FzuK4CDo3bjRztFe/RDAw4IxeCHWLB
X-Gm-Gg: ASbGncvkY9zOrdE/DZRWkaPh68HoHVyMo3Xx+jaytN5qDxmjAftaXMW8uWxOuDoI4RJ
	ms1Ts/jWsjSP9rXOoFEfyLSvBvlZvimN71NBcMJMNpYmr1HAr+voJ77zbwbaE8PrNi9AoMgp02Z
	ayk/+r3HUOvx7fdZj/ETIb4HWk3xMUrZr2Y/al6RLtVPruH/X6Kqxcgio55jwsDdbvv0gbmH9TT
	JZJcidPhpk0RtA7iCjCF+4l6311xNrOc/yDPexGVcYmbDqbK0bNw0TZFsUV8061ih/BWr6LrJtm
	yQ40YoWWsTWoynkfZYFwgarYq0IwqQ==
X-Google-Smtp-Source: AGHT+IEe3pc2lVsVkhnqLCSlyDpewTkSJC79/CsviL5DkUxD+u6OxER0DZOVHU5iwPxiRLJwA2Z93A==
X-Received: by 2002:a05:6402:40cf:b0:5d3:ba42:e9fa with SMTP id 4fb4d7f45d1cf-5d63c3405a8mr33138305a12.16.1734422571994;
        Tue, 17 Dec 2024 00:02:51 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ae12a7sm3990967a12.50.2024.12.17.00.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 00:02:51 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Dec 2024 09:02:49 +0100
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
	Laura Nao <laura.nao@collabora.com>, bpf@vger.kernel.org,
	chrome-platform@lists.linux.dev, kernel@collabora.com,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
Message-ID: <Z2EwKSgh0cA2EHun@krava>
References: <20241115171712.427535-1-laura.nao@collabora.com>
 <20241204155305.444280-1-laura.nao@collabora.com>
 <CAFULd4a+GjfN5EgPM-utJNfwo5vQ9Sq+uqXJ62eP9ed7bBJ50w@mail.gmail.com>
 <Z10MkXtzyY9RDqSp@pop-os.localdomain>
 <3be0346a-8bc9-4be1-8418-b26c7aa4a862@oracle.com>
 <c067bc3d-62d6-4677-9daf-17c57f007e67@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c067bc3d-62d6-4677-9daf-17c57f007e67@oracle.com>

On Mon, Dec 16, 2024 at 03:19:01PM +0000, Alan Maguire wrote:
> On 14/12/2024 12:15, Alan Maguire wrote:
> > On 14/12/2024 04:41, Cong Wang wrote:
> >> On Thu, Dec 05, 2024 at 08:36:33AM +0100, Uros Bizjak wrote:
> >>> On Wed, Dec 4, 2024 at 4:52 PM Laura Nao <laura.nao@collabora.com> wrote:
> >>>>
> >>>> On 11/15/24 18:17, Laura Nao wrote:
> >>>>> I managed to reproduce the issue locally and I've uploaded the vmlinux[1]
> >>>>> (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of the
> >>>>> modules[3] and its btf data[4] extracted with:
> >>>>>
> >>>>> bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko > cros_kbd_led_backlight.ko.raw
> >>>>>
> >>>>> Looking again at the logs[5], I've noticed the following is reported:
> >>>>>
> >>>>> [    0.415885] BPF:    type_id=115803 offset=177920 size=1152
> >>>>> [    0.416029] BPF:
> >>>>> [    0.416083] BPF: Invalid offset
> >>>>> [    0.416165] BPF:
> >>>>>
> >>>>> There are two different definitions of rcu_data in '.data..percpu', one
> >>>>> is a struct and the other is an integer:
> >>>>>
> >>>>> type_id=115801 offset=177920 size=1152 (VAR 'rcu_data')
> >>>>> type_id=115803 offset=177920 size=1152 (VAR 'rcu_data')
> >>>>>
> >>>>> [115801] VAR 'rcu_data' type_id=115572, linkage=static
> >>>>> [115803] VAR 'rcu_data' type_id=1, linkage=static
> >>>>>
> >>>>> [115572] STRUCT 'rcu_data' size=1152 vlen=69
> >>>>> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> >>>>>
> >>>>> I assume that's not expected, correct?
> >>>>>
> >>>>> I'll dig a bit deeper and report back if I can find anything else.
> >>>>
> >>>> I ran a bisection, and it appears the culprit commit is:
> >>>> https://lore.kernel.org/all/20241021080856.48746-2-ubizjak@gmail.com/
> >>>>
> >>>> Hi Uros, do you have any suggestions or insights on resolving this issue?
> >>>
> >>> There is a stray ";" at the end of the #define, perhaps this makes a difference:
> >>>
> >>> +#define PERCPU_PTR(__p) \
> >>> + (typeof(*(__p)) __force __kernel *)(__p);
> >>> +
> >>>
> >>> and SHIFT_PERCPU_PTR macro now expands to:
> >>>
> >>> RELOC_HIDE((typeof(*(p)) __force __kernel *)(p);, (offset))
> >>>
> >>> A follow-up patch in the series changes PERCPU_PTR macro to:
> >>>
> >>> #define PERCPU_PTR(__p) \
> >>> ({ \
> >>> unsigned long __pcpu_ptr = (__force unsigned long)(__p); \
> >>> (typeof(*(__p)) __force __kernel *)(__pcpu_ptr); \
> >>> })
> >>>
> >>> so this should again correctly cast the value.
> >>
> >> Hm, I saw a similar bug but with pahole 1.28. My kernel complains about
> >> BTF invalid offset:
> >>
> >> [    7.785788] BPF: 	 type_id=2394 offset=0 size=1
> >> [    7.786411] BPF:
> >> [    7.786703] BPF: Invalid offset
> >> [    7.787119] BPF:
> >>
> >> Dumping the vmlinux (there is no module invovled), I saw it is related to
> >> percpu pointer too:
> >>
> >> [2394] VAR '__pcpu_unique_cpu_hw_events' type_id=2, linkage=global
> >> ...
> >> [163643] DATASEC '.data..percpu' size=2123280 vlen=808
> >>         type_id=2393 offset=0 size=1 (VAR '__pcpu_scope_cpu_hw_events')
> >>         type_id=2394 offset=0 size=1 (VAR '__pcpu_unique_cpu_hw_events')
> >> ...
> >>
> >> I compiled and installed the latest pahole from its git repo:
> >>
> >> $ pahole --version
> >> v1.28
> >>
> >> Thanks.
> > 
> > Thanks for the report! Looking at percpu-defs.h it looks like the
> > existence of such variables requires either
> > 
> > #if defined(ARCH_NEEDS_WEAK_PER_CPU) ||
> > defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
> > 
> > ...
> > 
> > #define DEFINE_PER_CPU_SECTION(type, name, sec)                         \
> >         __PCPU_DUMMY_ATTRS char __pcpu_scope_##name;                    \
> >         extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;            \
> >         __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;                   \
> >         extern __PCPU_ATTRS(sec) __typeof__(type) name;                 \
> >         __PCPU_ATTRS(sec) __weak __typeof__(type) name
> > 
> > 
> > I'm guessing your .config has CONFIG_DEBUG_FORCE_WEAK_PER_CPU, or are
> > you building on s390/alpha?
> > 
> > I've reproduced this on bpf-next with CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y,
> > pahole v1.28 and gcc-12; I see ~900 __pcpu_ variables and get the same
> > BTF errors since multipe __pcpu_ vars share the offset 0.
> > 
> > A simple workaround in dwarves - and I verified this resolved the issue
> > for me - would be
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 3754884..4a1799a 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -2174,7 +2174,8 @@ static bool filter_variable_name(const char *name)
> >                 X("__UNIQUE_ID"),
> >                 X("__tpstrtab_"),
> >                 X("__exitcall_"),
> > -               X("__func_stack_frame_non_standard_")
> > +               X("__func_stack_frame_non_standard_"),
> > +               X("__pcpu_")
> >                 #undef X
> >         };
> >         int i;
> > 
> > ...but I'd like us to understand further why variables which were
> > supposed to be in a .discard section end up being encoded as there may
> > be other problems lurking here aside from this one. More soon hopefully...
> >
> 
> 
> A bit more context here - variable encoding takes the address of the
> variable from DWARF to locate the associated ELF section. Because we
> insist on having a variable specification - with a location - this
> usually works fine. However the problem is that because these dummy
> __pcpu_ variables specify a .discard section, their addresses are 0, so
> we get for example:
> 
>  <1><1e535>: Abbrev Number: 114 (DW_TAG_variable)
>     <1e536>   DW_AT_name        : (indirect string, offset: 0x5e97):
> __pcpu_unique_kstack_offset
>     <1e53a>   DW_AT_decl_file   : 1
>     <1e53b>   DW_AT_decl_line   : 823
>     <1e53d>   DW_AT_decl_column : 1
>     <1e53e>   DW_AT_type        : <0x57>
>     <1e542>   DW_AT_external    : 1
>     <1e542>   DW_AT_declaration : 1
>  <1><1e542>: Abbrev Number: 156 (DW_TAG_variable)
>     <1e544>   DW_AT_specification: <0x1e535>
>     <1e548>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0
> (DW_OP_addr: 0)
> 
> 
> You can see the same thing for a simple program like this:
> 
> #include <stdio.h>
> 
> #define SEC(name) __attribute__((section(name)))
> 
> SEC("/DISCARD/") int d1;
> extern int d1;
> SEC("/DISCARD/") int d2;
> extern int d2;
> 
> int main(int argc, char *argv[])
> {
> 	return 0;
> }
> 
> 
> If you compile it with -g, the DWARF shows that d1 and d2 both have
> address 0:
> 
>  <1><72>: Abbrev Number: 5 (DW_TAG_variable)
>     <73>   DW_AT_name        : d1
>     <76>   DW_AT_decl_file   : 1
>     <77>   DW_AT_decl_line   : 5
>     <78>   DW_AT_decl_column : 22
>     <79>   DW_AT_type        : <0x57>
>     <7d>   DW_AT_external    : 1
>     <7d>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0
> (DW_OP_addr: 0)
>  <1><87>: Abbrev Number: 5 (DW_TAG_variable)
>     <88>   DW_AT_name        : d2
>     <8b>   DW_AT_decl_file   : 1
>     <8c>   DW_AT_decl_line   : 7
>     <8d>   DW_AT_decl_column : 22
>     <8e>   DW_AT_type        : <0x57>
>     <92>   DW_AT_external    : 1
>     <92>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0
> (DW_OP_addr: 0)
> 
> 
> So the reason this happens for dwarves v1.28 in particular is - as I
> understand it - we moved away from recording ELF section information for
> each variable and matching that with DWARF info, instead relying on the
> address to locate the associated ELF section. In cases like the above
> the address information unfortunately leads us astray.
> 
> Seems like there's a few approaches we can take in fixing this:
> 
> 1. designate "__pcpu_" prefix as a variable prefix to filter out. This
> resolves the immediate problem but is too narrowly focused IMO and we
> may end up playing whack-a-mole with other dummy variable prefixes.
> 2. resurrect ELF section variable information fully; i.e. record a list
> of variables per ELF section (or at least per ELF section we care
> about). If variable is not on the list for the ELF section, do not
> encode it.
> 3. midway between the two; for the 0 address case specifically, verify
> that the variable name really _is_ in the associated ELF section. No
> need to create a local ELF table variable representation, we could just
> walk the table in the case of the 0 addresses.
> 
> Diff for approach 3 is as follows
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 3754884..21a0ab6 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2189,6 +2189,26 @@ static bool filter_variable_name(const char *name)
>         return false;
>  }
> 
> +bool variable_in_sec(struct btf_encoder *encoder, const char *name,
> size_t shndx)
> +{
> +       uint32_t sym_sec_idx;
> +       uint32_t core_id;
> +       GElf_Sym sym;
> +
> +       elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym,
> sym_sec_idx) {
> +               const char *sym_name;
> +
> +               if (sym_sec_idx != shndx || elf_sym__type(&sym) !=
> STT_OBJECT)
> +                       continue;
> +               sym_name = elf_sym__name(&sym, encoder->symtab);
> +               if (!sym_name)
> +                       continue;
> +               if (strcmp(name, sym_name) == 0)
> +                       return true;
> +       }
> +       return false;
> +}
> +
>  static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  {
>         struct cu *cu = encoder->cu;
> @@ -2258,6 +2278,11 @@ static int
> btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>                 if (filter_variable_name(name))
>                         continue;
> 
> +               /* A 0 address may be in a .discard section; ensure the
> +                * variable really is in this section by checking ELF
> symtab.
> +                */
> +               if (addr == 0 && !variable_in_sec(encoder, name, shndx))
> +                       continue;
>                 /* Check for invalid BTF names */
>                 if (!btf_name_valid(name)) {
>                         dump_invalid_symbol("Found invalid variable name
> when encoding btf",
> 
> 
> ...so slightly more complex than option 1, but a bit more general in its
> applicability to .discard section variables.
> 
> For the pahole folks, what do we think? Which option (or indeed other
> ones I haven't thought of) makes sense for a fix for this? Thanks!

I can reproduce this with the CONFIG_DEBUG_FORCE_WEAK_PER_CPU enable,
the fix looks fine, could you send formal patch?

thanks,
jirka

