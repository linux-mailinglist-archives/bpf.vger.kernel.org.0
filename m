Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592D53534D5
	for <lists+bpf@lfdr.de>; Sat,  3 Apr 2021 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbhDCRII (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Apr 2021 13:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236868AbhDCRIH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Apr 2021 13:08:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76DD061163;
        Sat,  3 Apr 2021 17:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617469684;
        bh=Egx97dzuD/LBKZT7rjY+JhBM6Ryi+QIgPiG85NCXdcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sd9I71zD1hSyIggKZ0EXBL59UiaxZlkugXTURkg7puRtv0FTR0wIeTLd9mr1kTwgF
         9vlJwRUx/Y2aO2TMZBNpquPpyMrRkQlQ0L6xEqbGmVMmdhq9qS0/pMkTtfqpXtO+mG
         aqBM1BJsGBJstowe1u8JhR3J/o9MLMZwMSYEcF1GO+BFnszHHzuDEb2H7SBINU45nu
         UQ4XBEurELSWDVspLQCXJ0NFspYwR++rMF7T+bbWrxH8QcBoTEYRo3FogAb7dkmxli
         1xGLaeV5Na32WLyABed4DQhiiSupo9RsJQnxH4pW6ZiVATGzzwTkPbqJlXZPYF61yb
         95Kw+qtFkxx2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9CB8840647; Sat,  3 Apr 2021 14:08:01 -0300 (-03)
Date:   Sat, 3 Apr 2021 14:08:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo <arnaldo.melo@gmail.com>,
        David Blaikie <dblaikie@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH dwarves] dwarf_loader: handle subprogram ret type with
 abstract_origin properly
Message-ID: <YGig8cHwNoccQwr+@kernel.org>
References: <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com>
 <CAENS6EsZ5OX9o=Cn5L1jmx8ucR9siEWbGYiYHCUWuZjLyP3E7Q@mail.gmail.com>
 <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com>
 <CAENS6EsiRsY1JptWJqu2wH=m4fkSiR+zD8JDD5DYke=ZnJOMrg@mail.gmail.com>
 <YGckYjyfxfNLzc34@kernel.org>
 <YGcw4iq9QNkFFfyt@kernel.org>
 <2d55d22b-d136-82b9-6a0f-8b09eeef7047@fb.com>
 <82dfd420-96f9-aedc-6cdc-bf20042455db@fb.com>
 <E9072F07-B689-402C-89F6-545B589EF7E4@gmail.com>
 <d4899252-af75-f284-a684-b33a7a12c840@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4899252-af75-f284-a684-b33a7a12c840@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Apr 02, 2021 at 12:41:47PM -0700, Yonghong Song escreveu:
> 
> 
> On 4/2/21 11:08 AM, Arnaldo wrote:
> > 
> > 
> > On April 2, 2021 2:42:21 PM GMT-03:00, Yonghong Song <yhs@fb.com> wrote:
> > > On 4/2/21 10:23 AM, Yonghong Song wrote:
> > :> Thanks. I checked out the branch and did some testing with latest
> > > clang
> > > > trunk (just pulled in).
> > > > 
> > > > With kernel LTO note support, I tested gcc non-lto, and llvm-lto
> > > mode,
> > > > it works fine.
> > > > 
> > > > Without kernel LTO note support, I tested
> > > >     gcc non-lto  <=== ok
> > > >     llvm non-lto  <=== not ok
> > > >     llvm lto     <=== ok
> > > > 
> > > > Surprisingly llvm non-lto vmlinux had the same "tcp_slow_start"
> > > issue.
> > > > Some previous version of clang does not have this issue.
> > > > I double checked the dwarfdump and it is indeed has the same reason
> > > > for lto vmlinux. I checked abbrev section and there is no cross-cu
> > > > references.
> > > > 
> > > > That means we need to adapt this patch
> > > >     dwarf_loader: Handle subprogram ret type with abstract_origin
> > > properly
> > > > for non merging case as well.
> > > > The previous patch fixed lto subprogram abstract_origin issue,
> > > > I will submit a followup patch for this.
> > > 
> > > Actually, the change is pretty simple,
> > > 
> > > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > > index 5dea837..82d7131 100644
> > > --- a/dwarf_loader.c
> > > +++ b/dwarf_loader.c
> > > @@ -2323,7 +2323,11 @@ static int die__process_and_recode(Dwarf_Die
> > > *die, struct cu *cu)
> > >          int ret = die__process(die, cu);
> > >          if (ret != 0)
> > >                  return ret;
> > > -       return cu__recode_dwarf_types(cu);
> > > +       ret = cu__recode_dwarf_types(cu);
> > > +       if (ret != 0)
> > > +               return ret;
> > > +
> > > +       return cu__resolve_func_ret_types(cu);
> > >   }
> > > 
> > > Arnaldo, do you just want to fold into previous patches, or
> > > you want me to submit a new one?
> > 
> > I can take care of that.
> > 
> > And I think it's time for to look at Jiri's test suite... :-)
> > 
> > It's a holiday here, so I'll take some time to get to this, hopefully I'll tag 1.21 tomorrow tho.
> 
> Thanks for taking care of this! Right, 1.21 looks very close.

So our HEAD now is this:


commit c03cd5c6ae0cec97d23edcf0a343bbff3df3c96a
Author: Yonghong Song <yhs@fb.com>
Date:   Thu Apr 1 16:55:34 2021 -0700

    dwarf_loader: Handle subprogram ret type with abstract_origin properly
    
    With latest bpf-next built with clang LTO (thin or full), I hit one test
    failures:
    
      $ ./test_progs -t tcp
      ...
      libbpf: extern (func ksym) 'tcp_slow_start': func_proto [23] incompatible with kernel [115303]
      libbpf: failed to load object 'bpf_cubic'
      libbpf: failed to load BPF skeleton 'bpf_cubic': -22
      test_cubic:FAIL:bpf_cubic__open_and_load failed
      #9/2 cubic:FAIL
      ...
    
    The reason of the failure is due to bpf program 'tcp_slow_start' func
    signature is different from vmlinux BTF. bpf program uses the following
    signature:
    
      extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked);
    
    which is identical to the kernel definition in linux:include/net/tcp.h:
    
      u32 tcp_slow_start(struct tcp_sock *tp, u32 acked);
    
    While vmlinux BTF definition like:
    
      [115303] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
              'tp' type_id=39373
              'acked' type_id=18
      [115304] FUNC 'tcp_slow_start' type_id=115303 linkage=static
    
    The above is dumped with `bpftool btf dump file vmlinux`.
    
    You can see the ret_type_id is 0 and this caused the problem.
    
    Looking at dwarf, we have:
    
    0x11f2ec67:   DW_TAG_subprogram
                    DW_AT_low_pc    (0xffffffff81ed2330)
                    DW_AT_high_pc   (0xffffffff81ed235c)
                    DW_AT_frame_base        ()
                    DW_AT_GNU_all_call_sites        (true)
                    DW_AT_abstract_origin   (0x11f2ed66 "tcp_slow_start")
    ...
    0x11f2ed66:   DW_TAG_subprogram
                    DW_AT_name      ("tcp_slow_start")
                    DW_AT_decl_file ("/home/yhs/work/bpf-next/net/ipv4/tcp_cong.c")
                    DW_AT_decl_line (392)
                    DW_AT_prototyped        (true)
                    DW_AT_type      (0x11f130c2 "u32")
                    DW_AT_external  (true)
                    DW_AT_inline    (DW_INL_inlined)
    
    We have a subprogram which has an abstract_origin pointing to the
    subprogram prototype with return type. Current one pass recoding cannot
    easily resolve this easily since at the time recoding for 0x11f2ec67,
    the return type in 0x11f2ed66 has not been resolved.
    
    To simplify implementation, I just added another pass to go through all
    functions after recoding pass. This should resolve the above issue.
    
    With this patch, among total 250999 functions in vmlinux, 4821 functions
    needs return type adjustment from type id 0 to correct values. The above
    failed bpf selftest passed too.
    
    Committer testing:
    
    Before:
    
      $ pfunct tcp_slow_start
      void tcp_slow_start(struct tcp_sock * tp, u32 acked);
      $
      $ pfunct --prototypes /sys/kernel/btf/vmlinux > before
      $ head before
      int fb_is_primary_device(struct fb_info * info);
      int arch_resume_nosmt(void);
      int relocate_restore_code(void);
      int arch_hibernation_header_restore(void * addr);
      int get_e820_md5(struct e820_table * table, void * buf);
      int arch_hibernation_header_save(void * addr, unsigned int max_size);
      int pfn_is_nosave(long unsigned int pfn);
      int swsusp_arch_resume(void);
      int amd_bus_cpu_online(unsigned int cpu);
      void pci_enable_pci_io_ecs(void);
      $
    
    After:
    
      $ pfunct -F btf ../build/bpf_clang_thin_lto/vmlinux -f tcp_slow_start
      u32 tcp_slow_start(struct tcp_sock * tp, u32 acked);
      $
      $ pfunct -F btf --prototypes ../build/bpf_clang_thin_lto/vmlinux > after
      $
      $ head after
      int fb_is_primary_device(struct fb_info * info);
      int arch_resume_nosmt(void);
      int relocate_restore_code(void);
      int arch_hibernation_header_restore(void * addr);
      int get_e820_md5(struct e820_table * table, void * buf);
      int arch_hibernation_header_save(void * addr, unsigned int max_size);
      int pfn_is_nosave(long unsigned int pfn);
      int swsusp_arch_resume(void);
      int amd_bus_cpu_online(unsigned int cpu);
      void pci_enable_pci_io_ecs(void);
      $
      $ diff -u before after | grep ^+ | wc -l
      1604
      $
    
      $ diff -u before after | grep tcp_slow_start
      -void tcp_slow_start(struct tcp_sock * tp, u32 acked);
      +u32 tcp_slow_start(struct tcp_sock * tp, u32 acked);
      $
      $ diff -u before after | grep ^[+-] | head
      --- before    2021-04-02 11:35:15.578160795 -0300
      +++ after     2021-04-02 11:33:34.204847317 -0300
      -void set_bf_sort(const struct dmi_system_id  * d);
      +int set_bf_sort(const struct dmi_system_id  * d);
      -void raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn, int reg, int len, u32 val);
      -void raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn, int reg, int len, u32 * val);
      +int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn, int reg, int len, u32 val);
      +int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn, int reg, int len, u32 * val);
      -void xen_find_device_domain_owner(struct pci_dev * dev);
      +int xen_find_device_domain_owner(struct pci_dev * dev);
      $
    
    The same results are obtained if using /sys/kernel/btf/vmlinux after
    rebooting with the kernel built from the ../build/bpf_clang_thin_lto/vmlinux
    file used in the above 'after' examples.
    
    Signed-off-by: Yonghong Song <yhs@fb.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Acked-by: David Blaikie <dblaikie@gmail.com>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Bill Wendling <morbo@google.com>
    Cc: Nick Desaulniers <ndesaulniers@google.com>
    Cc: bpf@vger.kernel.org
    Cc: dwarves@vger.kernel.org
    Cc: kernel-team@fb.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 026d13789ff912be..5dea8378d7d2a30b 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2198,6 +2198,34 @@ out:
 	return 0;
 }
 
+static int cu__resolve_func_ret_types(struct cu *cu)
+{
+	struct ptr_table *pt = &cu->functions_table;
+	uint32_t i;
+
+	for (i = 0; i < pt->nr_entries; ++i) {
+		struct tag *tag = pt->entries[i];
+
+		if (tag == NULL || tag->type != 0)
+			continue;
+
+		struct function *fn = tag__function(tag);
+		if (!fn->abstract_origin)
+			continue;
+
+		struct dwarf_tag *dtag = tag->priv;
+		struct dwarf_tag *dfunc;
+		dfunc = dwarf_cu__find_tag_by_ref(cu->priv, &dtag->abstract_origin);
+		if (dfunc == NULL) {
+			tag__print_abstract_origin_not_found(tag);
+			return -1;
+		}
+
+		tag->type = dfunc->tag->type;
+	}
+	return 0;
+}
+
 static int cu__recode_dwarf_types_table(struct cu *cu,
 					struct ptr_table *pt,
 					uint32_t i)
@@ -2637,6 +2665,16 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 	/* process merged cu */
 	if (cu__recode_dwarf_types(cu) != LSK__KEEPIT)
 		return DWARF_CB_ABORT;
+
+	/*
+	 * for lto build, the function return type may not be
+	 * resolved due to the return type of a subprogram is
+	 * encoded in another subprogram through abstract_origin
+	 * tag. Let us visit all subprograms again to resolve this.
+	 */
+	if (cu__resolve_func_ret_types(cu) != LSK__KEEPIT)
+		return DWARF_CB_ABORT;
+
 	if (finalize_cu_immediately(cus, cu, dcu, conf)
 	    == LSK__STOP_LOADING)
 		return DWARF_CB_ABORT;
