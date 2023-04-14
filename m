Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862A56E272E
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjDNPnj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNPni (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 11:43:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38526BB;
        Fri, 14 Apr 2023 08:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94EAC60FB8;
        Fri, 14 Apr 2023 15:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AEDC433D2;
        Fri, 14 Apr 2023 15:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681487016;
        bh=h08I4UOy8O/vtjA3/HDm61kRiDez4uSAqmuZ1CwmyKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+ECzy4SqCMH8bwiyhjQ9euvqHVKbvcLeCukW2ymofuf6GA7/E3fJT3/VqTlAPYlM
         WKQqWVBSNOCUNyQn/F/idt/Ui8effGoQvzoajqDVxeO4vI+OCzz+lmQQ8nFGCkpVB5
         m3LeiQl6OxvxAr53faXSmRecTvhvxUuX/yNNahppTdFpI7u4olbJJuwQbPjf7wZI0y
         0tZdQiDyqPmn94uKRuK6v5lzpJ2sz+rvTNqlr4gZpPIn8FB7GBq3+SI6s+d9CIFLlQ
         krrsfzY7rQ5jl6J9ZB2UutIVwp/ceKcakzBQTFEkjy8cIgxHq9R1QK8RvLdU3Cx9Ia
         D4UoQ8fD9lmew==
Date:   Fri, 14 Apr 2023 08:43:33 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     No Name <xbjfk.github@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        llvm@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: LLVM not detected in bpfutil due to LLVM 16 requiring c++17
Message-ID: <20230414154333.GA1931632@dev-arch.thelio-3990X>
References: <CALS7K9V1j6ufrQ=6nGjyHQCWb7-YiqNdctBWk8og1gW_q4C4dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALS7K9V1j6ufrQ=6nGjyHQCWb7-YiqNdctBWk8og1gW_q4C4dA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Reagan,

On Fri, Apr 14, 2023 at 10:36:35PM +1200, No Name wrote:
> This is my first time reporting a bug, so apologies if I get something wrong.

Thanks for the report! "See something, say something", even if it is not
quite right out of the gate, we can get down to the bottom of it.

> In tools/build/feature/Makefile, line 342, the c++ std is set to
> gnu++14, whereas LLVM 16 now requires c++17 to include the headers.
> This results in the llvm feature being falsely disabled for bpfutil.

I cannot find any reference to bpfutil either in tree or when doing a
web search, did you mean bpftool? I am going to assume yes, so I have
gone ahead and added Quentin (the maintainer of bpftool in MAINTAINERS)
and bpf@vger.kernel.org to the thread.

> Perhaps the --cxxflags, --ldflags and --libs options of llvm-config
> should instead?

The tools system is pretty much Greek to me, so I am hoping someone else
will have a better idea of what is going on and how to fix it.

For the record, I think I see the issue you are talking about on Fedora,
which has clang-16, whereas I do not see the same issue on Arch Linux,
which still has clang-15.

  $ clang --version | head -1
  clang version 15.0.7

  $ make -C tools/bpf/bpftool -j(nproc) -s

  Auto-detecting system features:
  ...                         clang-bpf-co-re: [ on  ]
  ...                                    llvm: [ on  ]
  ...                                  libcap: [ on  ]
  ...                                  libbfd: [ on  ]

compared to

  $ clang --version | head -1
  clang version 16.0.0 (Fedora 16.0.0-1.fc39)

  $ make -C tools/bpf/bpftool -j(nproc) -s

  Auto-detecting system features:
  ...                         clang-bpf-co-re: [ on  ]
  ...                                    llvm: [ OFF ]
  ...                                  libcap: [ on  ]
  ...                                  libbfd: [ on  ]

This is the output of tools/build/feature/test-llvm.make.output on my
machine, which seems to confirm that the headers expect to be compiled
with '-std=c++17', but that is just a superficial observation at this
point.

  In file included from /usr/include/llvm/Support/raw_ostream.h:16,
                   from test-llvm.cpp:3:
  /usr/include/llvm/ADT/SmallVector.h: In static member function ‘static void llvm::SmallVectorTemplateBase<T, <anonymous> >::uninitialized_move(It1, It1, It2)’:
  /usr/include/llvm/ADT/SmallVector.h:352:10: error: ‘uninitialized_move’ is not a member of ‘std’; did you mean ‘uninitialized_copy’?
    352 |     std::uninitialized_move(I, E, Dest);
        |          ^~~~~~~~~~~~~~~~~~
        |          uninitialized_copy
  In file included from /usr/include/llvm/ADT/StringRef.h:12,
                   from /usr/include/llvm/Support/raw_ostream.h:17:
  /usr/include/llvm/ADT/DenseMapInfo.h: At global scope:
  /usr/include/llvm/ADT/DenseMapInfo.h:294:52: error: ‘variant’ is not a member of ‘std’
    294 | template <typename... Ts> struct DenseMapInfo<std::variant<Ts...>> {
        |                                                    ^~~~~~~
  /usr/include/llvm/ADT/DenseMapInfo.h:294:52: note: ‘std::variant’ is only available from C++17 onwards
  /usr/include/llvm/ADT/DenseMapInfo.h:294:52: error: ‘variant’ is not a member of ‘std’
  /usr/include/llvm/ADT/DenseMapInfo.h:294:52: note: ‘std::variant’ is only available from C++17 onwards
  /usr/include/llvm/ADT/DenseMapInfo.h:294:62: error: expected parameter pack before ‘...’
    294 | template <typename... Ts> struct DenseMapInfo<std::variant<Ts...>> {
        |                                                              ^~~
  /usr/include/llvm/ADT/DenseMapInfo.h:294:62: error: template argument 1 is invalid
  /usr/include/llvm/ADT/DenseMapInfo.h:294:65: error: expected unqualified-id before ‘>’ token
    294 | template <typename... Ts> struct DenseMapInfo<std::variant<Ts...>> {
        |                                                                 ^~
  In file included from /usr/include/llvm/ADT/STLFunctionalExtras.h:18,
                   from /usr/include/llvm/ADT/StringRef.h:13:
  /usr/include/llvm/ADT/STLForwardCompat.h:46:35: error: ‘optional’ in namespace ‘std’ does not name a template type
     46 | auto transformOptional(const std::optional<T> &O, const Function &F)
        |                                   ^~~~~~~~
  /usr/include/llvm/ADT/STLForwardCompat.h:46:30: note: ‘std::optional’ is only available from C++17 onwards
     46 | auto transformOptional(const std::optional<T> &O, const Function &F)
        |                              ^~~
  /usr/include/llvm/ADT/STLForwardCompat.h:46:43: error: expected ‘,’ or ‘...’ before ‘<’ token
     46 | auto transformOptional(const std::optional<T> &O, const Function &F)
        |                                           ^
  /usr/include/llvm/ADT/STLForwardCompat.h:47:13: error: ‘optional’ in namespace ‘std’ does not name a template type
     47 |     -> std::optional<decltype(F(*O))> {
        |             ^~~~~~~~
  /usr/include/llvm/ADT/STLForwardCompat.h:47:8: note: ‘std::optional’ is only available from C++17 onwards
     47 |     -> std::optional<decltype(F(*O))> {
        |        ^~~
  /usr/include/llvm/ADT/STLForwardCompat.h:47:21: error: expected initializer before ‘<’ token
     47 |     -> std::optional<decltype(F(*O))> {
        |                     ^
  /usr/include/llvm/ADT/STLForwardCompat.h:56:29: error: ‘optional’ is not a member of ‘std’
     56 | auto transformOptional(std::optional<T> &&O, const Function &F)
        |                             ^~~~~~~~
  /usr/include/llvm/ADT/STLForwardCompat.h:56:29: note: ‘std::optional’ is only available from C++17 onwards
  /usr/include/llvm/ADT/STLForwardCompat.h:56:39: error: expected primary-expression before ‘>’ token
     56 | auto transformOptional(std::optional<T> &&O, const Function &F)
        |                                       ^
  /usr/include/llvm/ADT/STLForwardCompat.h:56:43: error: label ‘O’ referenced outside of any function
     56 | auto transformOptional(std::optional<T> &&O, const Function &F)
        |                                           ^
  /usr/include/llvm/ADT/STLForwardCompat.h:56:46: error: expected primary-expression before ‘const’
     56 | auto transformOptional(std::optional<T> &&O, const Function &F)
        |                                              ^~~~~
  /usr/include/llvm/ADT/STLForwardCompat.h:56:63: error: expression list treated as compound expression in initializer [-fpermissive]
     56 | auto transformOptional(std::optional<T> &&O, const Function &F)
        |                                                               ^
  /usr/include/llvm/ADT/STLForwardCompat.h:56:64: error: expected ‘;’ before ‘->’ token
     56 | auto transformOptional(std::optional<T> &&O, const Function &F)
        |                                                                ^
        |                                                                ;
     57 |     -> std::optional<decltype(F(*std::move(O)))> {
        |     ~~                                                          
  /usr/include/llvm/ADT/StringRef.h:104:54: error: expected ‘)’ before ‘Str’
    104 |     /*implicit*/ constexpr StringRef(std::string_view Str)
        |                                     ~                ^~~~
        |                                                      )
  /usr/include/llvm/ADT/StringRef.h:248:14: error: expected type-specifier
    248 |     operator std::string_view() const {
        |              ^~~
  /usr/include/llvm/ADT/StringRef.h: In member function ‘size_t llvm::StringRef::find(char, size_t) const’:
  /usr/include/llvm/ADT/StringRef.h:296:19: error: ‘string_view’ is not a member of ‘std’
    296 |       return std::string_view(*this).find(C, From);
        |                   ^~~~~~~~~~~
  /usr/include/llvm/ADT/StringRef.h:296:19: note: ‘std::string_view’ is only available from C++17 onwards
  /usr/include/llvm/Support/raw_ostream.h: At global scope:
  /usr/include/llvm/Support/raw_ostream.h:252:38: error: ‘string_view’ in namespace ‘std’ does not name a type
    252 |   raw_ostream &operator<<(const std::string_view &Str) {
        |                                      ^~~~~~~~~~~
  /usr/include/llvm/Support/raw_ostream.h:252:33: note: ‘std::string_view’ is only available from C++17 onwards
    252 |   raw_ostream &operator<<(const std::string_view &Str) {
        |                                 ^~~
  /usr/include/llvm/Support/raw_ostream.h: In member function ‘llvm::raw_ostream& llvm::raw_ostream::operator<<(const int&)’:
  /usr/include/llvm/Support/raw_ostream.h:253:22: error: request for member ‘data’ in ‘Str’, which is of non-class type ‘const int’
    253 |     return write(Str.data(), Str.length());
        |                      ^~~~
  /usr/include/llvm/Support/raw_ostream.h:253:34: error: request for member ‘length’ in ‘Str’, which is of non-class type ‘const int’
    253 |     return write(Str.data(), Str.length());
        |                                  ^~~~~~
  /usr/include/llvm/Support/raw_ostream.h: At global scope:
  /usr/include/llvm/Support/raw_ostream.h:459:16: error: ‘optional’ in namespace ‘std’ does not name a template type
    459 |   mutable std::optional<bool> HasColors;
        |                ^~~~~~~~
  /usr/include/llvm/Support/raw_ostream.h:459:11: note: ‘std::optional’ is only available from C++17 onwards
    459 |   mutable std::optional<bool> HasColors;
        |           ^~~
  /usr/include/llvm/Support/raw_ostream.h:757:47: error: ‘std::nullopt_t’ has not been declared
    757 | raw_ostream &operator<<(raw_ostream &OS, std::nullopt_t);
        |                                               ^~~~~~~~~
  /usr/include/llvm/Support/raw_ostream.h:761:53: error: ‘optional’ in namespace ‘std’ does not name a template type
    761 | raw_ostream &operator<<(raw_ostream &OS, const std::optional<T> &O) {
        |                                                     ^~~~~~~~
  /usr/include/llvm/Support/raw_ostream.h:761:48: note: ‘std::optional’ is only available from C++17 onwards
    761 | raw_ostream &operator<<(raw_ostream &OS, const std::optional<T> &O) {
        |                                                ^~~
  /usr/include/llvm/Support/raw_ostream.h:761:61: error: expected ‘,’ or ‘...’ before ‘<’ token
    761 | raw_ostream &operator<<(raw_ostream &OS, const std::optional<T> &O) {
        |                                                             ^
  /usr/include/llvm/Support/raw_ostream.h: In function ‘llvm::raw_ostream& llvm::operator<<(raw_ostream&, int)’:
  /usr/include/llvm/Support/raw_ostream.h:762:7: error: ‘O’ was not declared in this scope; did you mean ‘OS’?
    762 |   if (O)
        |       ^
        |       OS
  /usr/include/llvm/Support/raw_ostream.h:765:16: error: ‘nullopt’ is not a member of ‘std’
    765 |     OS << std::nullopt;
        |                ^~~~~~~
  /usr/include/llvm/Support/raw_ostream.h:765:16: note: ‘std::nullopt’ is only available from C++17 onwards

Cheers,
Nathan
