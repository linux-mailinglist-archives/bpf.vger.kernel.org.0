Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DEF695221
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 21:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBMUpc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 15:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBMUpb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 15:45:31 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D4E83FB
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 12:45:29 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DJaVeN028583;
        Mon, 13 Feb 2023 12:45:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=tpt2MYCGz1MpoL+U6w1jjptpAr7onM7LBqksovjg7vk=;
 b=RXheRpZyOeSsME6ukePi5bVmk8MMBQGEywvQ0wmNafMCvsMTHL0D0y0GGaH5FcRfmL8x
 Sps+PVzvq2F8ZQqQOEYgFK7HG4HTIq6HamvnLV6Vn1ynNf9i82wnfKLKsljdumWTZKJv
 yJNt0h2a10rWqV/BxCd0ds5nLFUmTmbCaLUghDqCuBb3AOfz2OOtCfe6ok0wlHxbi5/5
 XAnJfZfmpXRWgq45JHYnytqzxi31PYASjTxdnyUZFxxKk2zk/o1A4dYmj3JpYVw/WMD9
 6J56RWXzFVUQ9CrJYgIlHaMU2CNT0SsxELjYV2VpEls3gstqz0oxhP2Jd/qEkfiDs8+o zg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3np9e5erb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 12:45:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZx6xjyjCHjf7EAtb+wxP2TRHqQpmIEX4HwepAl0yjl3JpgOWTElcuEQCBD7/pzzVy2xu8FUNYXMnwk62l6OFxYSG1ps0+4eSRu5G8pz6p41y3Ysr60lGDnIMjuPPw9Auh2QgcPeo0ERrM2cDHPKnIRiA7cJmBhdrcywQKxPOmO+VFUwWJ4hWqMPyLQfvMCUhLvPouB6OwBWqO1tPIo5pyY8zs3zsw2UoQ8d57FAP6++lk/JMVUif7e0GS8boMZ6AYvWmGMggWlm+eJgVH8o2korQVJ31404ZZt3NXiKhg7X6VJi1+I5gk9IbVbpPqpqdD6H7uZ4JVd4boO9QZ5AGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=On5s0UNvFljwQXJbofQbUBs68x9+6QtyxckwMO/Y6sI=;
 b=Zn84vvxQAGRPpl9lvsnTOG4YVriwnFIeTqNw+7BzUuM9lh/g7YTGz9r1+rEgLG8b46/kJQd9cAns7djAJ9z7I/PAwcUSltI2kPagtxa+HSsUIWUOa65axLNiBkQI7lOjUiO8ZEF+t2E/22tM2FpOyLxG8kImNqwaK/HPSeRirMULO+kOQ+Z1qGTO7YfHLRTTVikbitk296L4ipXaF4x7Z6FR88M1OQ2OMJA82eXjdTHtlajegV+N9xFljnB/6BSYKYNiCN15ZT4MeW+HhJxQE/wWvvoDtKN5syDFhjEY2gLObOxNarEOq7BCze9uuMe8TMdeWgDoenhesxXCTGz0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by SN7PR15MB6071.namprd15.prod.outlook.com (2603:10b6:806:2e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 20:45:04 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::2d1e:2330:470c:28bd]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::2d1e:2330:470c:28bd%5]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 20:45:04 +0000
Message-ID: <d04d33ff-0f8f-2bbd-3a67-9b8b813a799b@meta.com>
Date:   Mon, 13 Feb 2023 15:44:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v5 bpf-next 3/9] bpf: Add bpf_rbtree_{add,remove,first}
 kfuncs
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20230212092715.1422619-4-davemarchevsky@fb.com>
 <202302121936.t36vlAFG-lkp@intel.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <202302121936.t36vlAFG-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BLAPR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:208:36e::29) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|SN7PR15MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c80c87-6eb8-410b-0350-08db0e032f45
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /OJHlUSOjWaqQCUsXD34bPDUT1jNfTMrUcowtsauY8A+FZGybgieNY57svlXTJX42+UgcTD9I33qolv9gq33tHg3rFItpspcuzax66UBazIYBglMY3wsDmh/0f4Wfg1I5ciAaGpiCbMo2mGBD9VGaJgF0di8QmoGALpVwsbdNcSuFjXHYcPU66ZDf9xWLLkFuzi/kcwzvl5Xz8Pn/9MgZmtlCA+W3Rm74pg4vHijGlWFQ/IVT65Tg10yH/tWr5oTJPZiwA4fFUZoFVGXeM4uxRsjD35rFWL24BsMQBf9nBoeqxZoZyigYB+mdRub/69Hg7jQ+z8jkE/iVYtMDE3irrfi5NfqTGSF7t29Zcz6WBfLtEz7DwRwvZ6c0FZpI2X0jtZtrRVjdiwoCMv2Xmi59g2BQ4dRDjbHR6GHevx16ykldR1OFnz6aAL9xYQzzlfNtZrJQXjCq8jruwZmKiu37gj/Ufbvb/M+CzATHuGiuLeWCubaIFATwatpe5OiTew1VfNGCj31c7cVrk7VXfCILQ70ecARzqwI2QEsTQA54CuFXuJ4/DGyELcYTBvnalPxbzI54bDR9w+Bh+fJWsPNTYIMkm4WGzFaf35+xd5mW28oZe5O+M9Cw/fMAE9dg7d8tiUn0w6+DtAoXdV6/MhvAi+XP6CjaakJ5m43kfwx4cLdqntqHrQ6IRMexYgEso+HTaHJMviQEQFD/Kq61zY52ebQAbepNdWdOmpHtReBg4EJ74ltgxcWqyPbRBvw9537g4HKGSAu0h1UW2WDDuOEjbxPHhM4AziWrf8O/l/rQYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199018)(4326008)(8936002)(41300700001)(83380400001)(36756003)(38100700002)(31696002)(86362001)(5660300002)(2906002)(110136005)(54906003)(6512007)(186003)(6666004)(53546011)(6506007)(966005)(478600001)(31686004)(6486002)(66946007)(316002)(66556008)(8676002)(2616005)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0Vsck1sZHh1bG9PK0ZrZHpIOUo2TlJJMDh4NDc5Wk1RZFk5blZrSVR2eGlO?=
 =?utf-8?B?dCs0SzZzb2VZNWpaTDR5amJIVEJwQWQ2ZE1Bekt0UHZIaml6a0NCNktLZWNa?=
 =?utf-8?B?MjFCQTRmRmFvLzZ2VlVUOTc4alNDVWR4TW15b3NNTEQ4cGhhT0RHMWRQb2hF?=
 =?utf-8?B?emJVRWFOaEdCWGJ0ZENGeG9qMmVVNW1FZ2JTcnNocDgzM21YL0ZPanJCbmNO?=
 =?utf-8?B?d3ZQWS9rWW5MVmplVmwrRW53VS90ZktlSVJ4eGZPYzRMTkRKK3JoSlhGR3pS?=
 =?utf-8?B?OTdHS1IyR2YySGZ0WnE0OGRoY0VSMmpRK2hFVmcwMkcvTGdNTTF4S1lMWkFq?=
 =?utf-8?B?dzlacjFKRGIweFdTZzhKcFBtVk05TVBLbmJBRWJhZzRSQTd1K1p5dEpybVNn?=
 =?utf-8?B?cnRKODZjTG9JSGlNYUhvV1hZUHVtSERYRWk3ZGFuZ0x3anF5Z1l2b2hSNTM2?=
 =?utf-8?B?NGxlR2VYNjFSUC9yeGZVMFhJZHhjWitJY2JkZmJPejNCaVVBUERsYkZkOHhy?=
 =?utf-8?B?bWFoS200Y1UvTC9uYjVkK1F5RjJ2MHovTmYvR1ZGa041eTlMS3VLdzdOSjdw?=
 =?utf-8?B?TlpldGZmM20weEI3ZUVpK1lZZUtGR3BMbG91SGQ2aEgxaklvaXZVbTZNM3RB?=
 =?utf-8?B?NmtUdXhGOHlDUjBqRUNUOXo3RHFCa1QrU2VxVmViWFFYYmovWE14c1hTWHpm?=
 =?utf-8?B?ZjhKbkJ3NzAwNmREaDQ1RHJoUWwxZHNLSEErYUZpRHFwelRJZnFzWWVwY2JX?=
 =?utf-8?B?di9xNlp5K1JpcnczaXRhUkdHOVg2WW5rRkl0ZDhsN1VwSW1mVDVmQ0dEQzRt?=
 =?utf-8?B?MHh0VWErdGdQSlpOejdSMnB1MW9sMlc0d2RJUU5nd09XV3BlY0tmZFdQTUwz?=
 =?utf-8?B?dHZpNnNQTU1TMWdwc08xTFlTdzBsN1dtU0ZjM3FVU01GWXRybzNLQTRrd0E5?=
 =?utf-8?B?M1BpMWtPekUyZDRpYVBMSGF5WXFuMlQzcExoY3M5bnhRQVY2SDlvWnE0dlVa?=
 =?utf-8?B?MUVjZ1Blb1MydkxTMXhTMHMwK0NhTEJ3U1h2U3RLd0h2R3pUanM4dG41QVRK?=
 =?utf-8?B?Y09hd2F6V25uUHhIc2ltU043S2FLSUVVSDhxUk83MEFIbFpvZi9xZXQ4MlBv?=
 =?utf-8?B?aTVsN3RGSDVYb2Rpdm8zZ2RKZXJHZDdraTRnK1ZRK0ozL3lDZ21EU0o0SlhP?=
 =?utf-8?B?TzYyRUVpZCtYRi85eE5CUWlFVVhKdnVvbW55b1RYOFJ5SW5uNnhVNVR3YmpK?=
 =?utf-8?B?R1RrN1B3UFg1SUo0TWU0aXlRUVVzdFl0VGRhNk95YnpyZVRvREU5bms5UEhM?=
 =?utf-8?B?dTJWaUxDaG1EQnk3cTMydWdLWXRvUFUraE9vZzljbS9Wc2hxZFZtQ0trSk5Z?=
 =?utf-8?B?V1JPcWl0YUpmMGFIaDArSUJxZmlYWFVBbjVIWWFMNE5LMzRFWXBkSnRseml6?=
 =?utf-8?B?ZnlYb2ltTmxYdWhqdlBac1cyUlBzcTcrWExLWDEyYk1tUlVXTFllbnorZU5W?=
 =?utf-8?B?ODdmdnhwbGZHNitKRjJDV0JEek1lM29Pa1pjaTQ0bHFTYi9wVjFsWFJQNnlJ?=
 =?utf-8?B?NDFYRjhlQm5IaFZ6bG01aWhLdWJuc095V0pGVXR3YVAvaEpDVjZrbHpDQXFJ?=
 =?utf-8?B?emZPV1hWTlNtbi8yY0JhcWFrTlFmcDl6TFFtRlNacXNCUlZVVlhSNnB4ZlJY?=
 =?utf-8?B?MldILytPMEhJSU5mYWNyNEF4VnpJYSt1WWpSeGxlNk93bHlocnJSVUZmMHQ4?=
 =?utf-8?B?b2UyYS9vcDJrUC83UXUvV3ZQSlpWWWlzQ01EU0taZEp0eWl4MFM2L1R6SzFS?=
 =?utf-8?B?VTg3L3N6ZGFmeVJaSndvVVhPU3RUdTFBdFNjcjlsODRnVWYveUl5c2tCR0xN?=
 =?utf-8?B?RjR3enVqSlFXTGpyWEhPSllkSDNiQ0dObUFuZWdBMll6L1lQTmtMcXN1NGM1?=
 =?utf-8?B?cDRlSGRjY1pEbHpFWllURGZxeENvVmM1Z2lvNWd1SUdZczlJeTdsZStvOFQ1?=
 =?utf-8?B?dERtUnhDckM3VnVJNEUvb2V1dzF6Tk9tdHNwRVdDYUxWelRvSkMwdG9xVFhN?=
 =?utf-8?B?NGZaWmtrLzRRc1ZvaW1xZFFzVTNTODI0dmJ1VWJOY0Q3T1FQR2lLYjlWd005?=
 =?utf-8?B?OGdJMDlaV1RkZFVENXFVa1dlb0QzdW1hcVRLVUkwMGJvdnBWaDdrQ3A0cWlx?=
 =?utf-8?Q?FsALo1tirqbMx08EGBN1zTs=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c80c87-6eb8-410b-0350-08db0e032f45
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 20:45:04.5688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+rtowwLTQSENB8EWgAw2RlX3jVQKW585pBIAmpuWUNIJYGwYkciE8miduFf0haSJ8SHo9oZ+G6GNy3dy0vYiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB6071
X-Proofpoint-GUID: 7ssxXt6hGO8xC7jqPVJYw5tdpwas9TtQ
X-Proofpoint-ORIG-GUID: 7ssxXt6hGO8xC7jqPVJYw5tdpwas9TtQ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/12/23 6:21 AM, kernel test robot wrote:
> Hi Dave,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Marchevsky/bpf-Migrate-release_on_unlock-logic-to-non-owning-ref-semantics/20230212-172813
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20230212092715.1422619-4-davemarchevsky%40fb.com
> patch subject: [PATCH v5 bpf-next 3/9] bpf: Add bpf_rbtree_{add,remove,first} kfuncs
> config: hexagon-randconfig-r045-20230212 (https://download.01.org/0day-ci/archive/20230212/202302121936.t36vlAFG-lkp@intel.com/config )
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/39ccb1ecaa4f95d55dfd9ba495ecefe3fe1f6982
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Dave-Marchevsky/bpf-Migrate-release_on_unlock-logic-to-non-owning-ref-semantics/20230212-172813
>         git checkout 39ccb1ecaa4f95d55dfd9ba495ecefe3fe1f6982
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/bpf/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302121936.t36vlAFG-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from kernel/bpf/helpers.c:4:
>    In file included from include/linux/bpf.h:31:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:26:
>    In file included from include/linux/kernel_stat.h:9:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val = __raw_readb(PCI_IOBASE + addr);
>                              ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>                                                            ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                      ^
>    In file included from kernel/bpf/helpers.c:4:
>    In file included from include/linux/bpf.h:31:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:26:
>    In file included from include/linux/kernel_stat.h:9:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>                                                            ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                      ^
>    In file included from kernel/bpf/helpers.c:4:
>    In file included from include/linux/bpf.h:31:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:26:
>    In file included from include/linux/kernel_stat.h:9:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writeb(value, PCI_IOBASE + addr);
>                                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>                                                          ~~~~~~~~~~ ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>                                                          ~~~~~~~~~~ ^
>>> kernel/bpf/helpers.c:1901:9: warning: cast from 'bool (*)(struct bpf_rb_node *, const struct bpf_rb_node *)' (aka '_Bool (*)(struct bpf_rb_node *, const struct bpf_rb_node *)') to 'bool (*)(struct rb_node *, const struct rb_node *)' (aka '_Bool (*)(struct rb_node *, const struct rb_node *)') converts to incompatible function type [-Wcast-function-type-strict]
>                          (bool (*)(struct rb_node *, const struct rb_node *))less);
>                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is the only new warning introduced by this series. A previous version had
the same complaint by kernel test robot.

struct bpf_rb_node is an opaque struct with the same size as struct rb_node.
It's not intended to be manipulated directly by any BPF program or bpf-rbtree
kernel code, but rather to be used as a struct rb_node by rbtree library
helpers.

Here, the compiler complains that the less() callback taken by bpf_rbtree_add
is typed 

bool (*)(struct bpf_rb_node *, const struct bpf_rb_node *)

while the actual rbtree lib helper rb_add's less() is typed

bool (*)(struct rb_node *, const struct rb_node *)

I'm not a C standard expert, but based on my googling, for C99 it's not valid
to cast a function pointer to anything aside from void* and its original type.
Furthermore, since struct bpf_rb_node an opaque bitfield and struct rb_node
has actual members, C99 standard 6.2.7 paragraph 1 states that they're not
compatible:

  Moreover, two structure,
  union, or enumerated types declared in separate translation units are compatible if their
  tags and members satisfy the following requirements: If one is declared with a tag, the
  other shall be declared with the same tag. If both are complete types, then the following
  additional requirements apply: there shall be a one-to-one correspondence between their
  members such that each pair of corresponding members are declared with compatible
  types, and such that if one member of a corresponding pair is declared with a name, the
  other member is declared with the same name. For two structures, corresponding
  members shall be declared in the same order

I'm not sure how to proceed here. We could change bpf_rbtree_add's less() cb to
take two rb_node *'s, but then each such cb implementation would have to cast
its parameters before doing anything useful with them. Furthermore this would
require introducing non-opaque rb_node type into BPF programs. Other ideas seem
similarly hacky.

Note that this flag was only recently introduced [0] and discussion in that
linked thread notes that ~1500 other places in the kernel raise same warning.


  [0]: https://reviews.llvm.org/D134831



>    7 warnings generated.
> 
> 
> vim +1901 kernel/bpf/helpers.c
> 
>   1896	
>   1897	void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
>   1898			    bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b))
>   1899	{
>   1900		rb_add_cached((struct rb_node *)node, (struct rb_root_cached *)root,
>> 1901			      (bool (*)(struct rb_node *, const struct rb_node *))less);
>   1902	}
>   1903	
> 
